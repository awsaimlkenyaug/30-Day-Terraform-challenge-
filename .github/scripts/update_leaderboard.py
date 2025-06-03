import os
import pandas as pd
from github import Github
from datetime import datetime, timezone
from collections import defaultdict
import glob

def calculate_points(pr, commits):
    points = 0
    
    # Points for PR submission (10 points per PR)
    points += 10
    
    # Points for number of commits (max 5 points)
    points += min(len(commits), 5)
    
    # Points for code quality (based on PR size and structure)
    files_changed = pr.changed_files
    if 1 <= files_changed <= 5:
        points += 3
    elif 5 < files_changed <= 10:
        points += 2
    else:
        points += 1

    # Points for documentation
    if any('md' in file.filename for file in pr.get_files()):
        points += 2

    return points

def count_completed_days(participant):
    """Count the number of days completed by checking submission files"""
    completed_days = set()
    print(f"\nChecking submissions for participant: {participant}")
    
    # Check all Day* directories for submissions
    for day_dir in glob.glob('Day*'):
        if day_dir.startswith('Day'):
            try:
                day_num = int(day_dir[3:])  # Extract number after 'Day'
                # Look for submission file in Day*/Submissions/username
                submission_path = os.path.join(day_dir, 'Submissions', f"{participant}")
                print(f"Checking path: {submission_path}")
                if os.path.exists(submission_path):
                    print(f"Found submission for Day {day_num}")
                    completed_days.add(day_num)
            except ValueError:
                continue
    
    print(f"Total days completed: {len(completed_days)}")
    return completed_days

def generate_leaderboard():
    # Initialize GitHub client
    g = Github(os.environ['GITHUB_TOKEN'])
    repo = g.get_repo(os.environ['GITHUB_REPOSITORY'])
    print("\nStarting leaderboard generation...")

    # Get all PRs
    participants = defaultdict(lambda: {
        'points': 0,
        'prs_merged': 0,
        'last_activity': datetime.min.replace(tzinfo=timezone.utc),
        'days_completed': set()
    })

    # Analyze PRs
    print("\nAnalyzing PRs...")
    for pr in repo.get_pulls(state='closed'):
        if not pr.merged:
            continue

        author = pr.user.login
        commits = list(pr.get_commits())
        
        # Calculate points from PR
        points = calculate_points(pr, commits)
        
        # Update participant stats
        participants[author]['points'] += points
        participants[author]['prs_merged'] += 1
        participants[author]['last_activity'] = max(
            participants[author]['last_activity'],
            pr.merged_at
        )

    # Count completed days for each participant
    print("\nCounting completed days...")
    for author in participants.keys():
        completed_days = count_completed_days(author)
        participants[author]['days_completed'] = completed_days
        # Add bonus points for completed days (20 points per day)
        participants[author]['points'] += len(completed_days) * 20

    # Convert to DataFrame
    if not participants:
        # Create empty DataFrame with correct columns
        df = pd.DataFrame(columns=[
            'Participant',
            'Points',
            'Days Completed',
            'PRs Merged',
            'Last Activity',
            'Progress'
        ])
    else:
        df = pd.DataFrame([
            {
                'Participant': author,
                'Points': stats['points'],
                'Days Completed': len(stats['days_completed']),
                'PRs Merged': stats['prs_merged'],
                'Last Activity': stats['last_activity'].strftime('%Y-%m-%d'),
                'Progress': f"{len(stats['days_completed'])/30*100:.1f}%"
            }
            for author, stats in participants.items()
        ])

    # Sort by points and days completed
    if not df.empty:
        df = df.sort_values(['Points', 'Days Completed'], ascending=[False, False])

    print("\nGenerating markdown...")
    # Generate markdown
    markdown = """# 🏆 Challenge Leaderboard

Updated at: {}

## 🎯 Points System
- 20 points for each completed day (with submission)
- 10 points for each merged PR
- Up to 5 points for commits in a PR
- Up to 3 points for code quality
- 2 points for documentation

## 🎯 Top Participants

{}

## 📊 Statistics
- Total Participants: {}
- Total Days Completed: {}
- Total PRs Merged: {}
- Average Completion: {:.1f}%
""".format(
        datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC'),
        df.to_markdown(index=False) if not df.empty else "No participants yet.",
        len(df),
        df['Days Completed'].sum() if not df.empty else 0,
        df['PRs Merged'].sum() if not df.empty else 0,
        df['Days Completed'].mean() / 30 * 100 if not df.empty else 0
    )

    print("\nWriting leaderboard file...")
    # Write to file
    with open('LEADERBOARD.md', 'w') as f:
        f.write(markdown)

    print("Leaderboard generation complete!")

if __name__ == '__main__':
    generate_leaderboard() 