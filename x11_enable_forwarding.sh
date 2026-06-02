xhost +local:

# Check the exit status of the xhost command
if [ $? -eq 0 ]; then
    echo "Success: xhost +local: command executed successfully."
else
    echo "Error: xhost +local: command failed."
fi


