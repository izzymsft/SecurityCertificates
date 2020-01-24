#!/bin/bash

echo "Removing Serial Number Tracker"
echo ""
rm -f serial*

echo "Removing Certificate Index"
echo ""
rm -f certindex.txt*

echo "Removing Previously Generated Certificates"
echo ""
rm -fR *_certificates

echo "Regenerating Serial Number Tracker and Certificate Index"
echo ""

echo '100001' > serial && touch certindex.txt

echo "Reset Complete"
