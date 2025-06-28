#!/bin/bash

# Replace @chiche with @awsaimlkenyaug
find . -type f -name "*.md" -exec sed -i 's/@chiche/@awsaimlkenyaug/g' {} \;

# Replace @Chi Che. with @awsaimlkenyaug
find . -type f -name "*.md" -exec sed -i 's/@Chi Che\./@awsaimlkenyaug/g' {} \;

# Replace HUGYDE with HUGMERU
find . -type f -name "*.md" -exec sed -i 's/HUGYDE/HUGMERU/g' {} \; 