
flowers=("Rose" "Tulip" "Daisy" "Sunflower")

echo "Flowers in the array: ${flowers[@]}"
i=0
for i in "${!flowers[@]}"; do
  echo "Flower $((i + 1)): ${flowers[$i]}"
done
echo "Total number of flowers: ${#flowers[@]}"