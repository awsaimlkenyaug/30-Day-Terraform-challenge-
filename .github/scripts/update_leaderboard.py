import os
import pandas as pd
from github import Github
from datetime import datetime, timezone
from collections import defaultdict

# Define check-in dates
CHECKIN_DATES = [
    "2024-05-24",
    "2024-05-31",
    "2024-06-07",
    "2024-06-14"
]

def calculate_points(pr, commits, comments):
    points = 0
    
    # Points for PR submission
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

    # Points for community engagement (comments)
    points += min(len(comments), 5)

    return points

def get_checkin_points(repo, participant):
    points = 0
    # Look for check-in confirmation issues/comments by repo owner
    for date in CHECKIN_DATES:
        # Search for check-in confirmation issues
        query = f"check-in {date} {participant} in:title repo:{repo.full_name}"
        issues = repo.get_issues(state='all', labels=['check-in'])
        
        for issue in issues:
            if (date in issue.title and 
                participant in issue.title and 
                issue.user.login == repo.owner.login):
                points += 5
                break
    
    return points

def generate_leaderboard():
    # Initialize GitHub client
    g = Github(os.environ['GITHUB_TOKEN'])
    repo = g.get_repo(os.environ['GITHUB_REPOSITORY'])

    # Get all PRs
    participants = defaultdict(lambda: {
        'points': 0,
        'prs_merged': 0,
        'last_activity': datetime.min.replace(tzinfo=timezone.utc),
        'days_completed': set(),
        'checkins_attended': 0
    })

    # Add test participant for development
    test_participant = "awsaimlkenyaug"  # Your GitHub username
    participants[test_participant] = {
        'points': 25,  # Example points
        'prs_merged': 2,
        'last_activity': datetime.now(timezone.utc),
        'days_completed': {1, 2},  # Completed days 1 and 2
        'checkins_attended': 1  # Attended one check-in
    }

    # Analyze PRs
    for pr in repo.get_pulls(state='closed'):
        if not pr.merged:
            continue

        author = pr.user.login
        commits = list(pr.get_commits())
        comments = list(pr.get_issue_comments())
        
        # Calculate points from PR
        points = calculate_points(pr, commits, comments)
        
        # Add check-in points
        checkin_points = get_checkin_points(repo, author)
        points += checkin_points
        
        # Update participant stats
        participants[author]['points'] += points
        participants[author]['prs_merged'] += 1
        participants[author]['last_activity'] = max(
            participants[author]['last_activity'],
            pr.merged_at
        )
        participants[author]['checkins_attended'] = checkin_points // 5

        # Track completed days
        if 'Day' in pr.title:
            try:
                day_num = int(''.join(filter(str.isdigit, pr.title.split('Day')[1])))
                participants[author]['days_completed'].add(day_num)
            except (ValueError, IndexError):
                pass

    # Convert to DataFrame
    if not participants:
        # Create empty DataFrame with correct columns
        df = pd.DataFrame(columns=[
            'Participant',
            'Points',
            'PRs Merged',
            'Days Completed',
            'Check-ins',
            'Last Activity',
            'Progress'
        ])
    else:
        df = pd.DataFrame([
            {
                'Participant': author,
                'Points': stats['points'],
                'PRs Merged': stats['prs_merged'],
                'Days Completed': len(stats['days_completed']),
                'Check-ins': stats['checkins_attended'],
                'Last Activity': stats['last_activity'].strftime('%Y-%m-%d'),
                'Progress': f"{len(stats['days_completed'])/30*100:.1f}%"
            }
            for author, stats in participants.items()
        ])

    # Sort by points and days completed (if DataFrame is not empty)
    if not df.empty:
        df = df.sort_values(['Points', 'Days Completed', 'Check-ins'], ascending=[False, False, False])

    # Generate markdown
    markdown = """# 🏆 Challenge Leaderboard

Updated at: {}

## 🎯 Top Participants

{}

## 📊 Statistics
- Total Participants: {}
- Total PRs Merged: {}
- Average Completion: {}%
- Total Check-ins: {}
- Average Check-in Attendance: {}%

## 📅 Next Check-in
{}

## 🎉 Perfect Attendance
{}
""".format(
        datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC'),
        df.to_markdown(index=False) if not df.empty else "No participants yet.",
        len(df),
        df['PRs Merged'].sum() if not df.empty else 0,
        df['Days Completed'].mean() / 30 * 100 if not df.empty else 0,
        df['Check-ins'].sum() if not df.empty else 0,
        df['Check-ins'].mean() / len(CHECKIN_DATES) * 100 if not df.empty else 0,
        get_next_checkin(),
        get_perfect_attendance(df)
    )

    # Write to file
    with open('LEADERBOARD.md', 'w') as f:
        f.write(markdown)

def get_next_checkin():
    now = datetime.now()
    for date in CHECKIN_DATES:
        checkin_date = datetime.strptime(date, '%Y-%m-%d')
        if checkin_date > now:
            return f"Next check-in: {date} at 6:00 PM EAT"
    return "All check-ins completed!"

def get_perfect_attendance(df):
    if df.empty:
        return "No participants have perfect attendance yet."
    perfect = df[df['Check-ins'] == len(CHECKIN_DATES)]['Participant'].tolist()
    if perfect:
        return "Participants with perfect check-in attendance:\n" + "\n".join(f"- {p}" for p in perfect)
    return "No participants have perfect attendance yet."

if __name__ == '__main__':
    generate_leaderboard() 