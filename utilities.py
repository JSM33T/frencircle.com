import os
import shutil
import subprocess
import shlex

def execute(command, target_dir):
    # Navigate to the target directory
    os.chdir(os.path.join(target_dir))

    # Split the command by words
    command_parts = shlex.split(command)

    # Run the command
    try:
        subprocess.run(command_parts, check=True, shell=True)
        print(f"Command '{command}' completed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Command '{command}' failed with error: {e}")


def copy_files(source, destination):
    """
    Copies all contents (files and subdirectories) from the source directory to the destination directory.

    :param source: The directory where contents will be copied from.
    :param destination: The directory where contents will be copied to.
    """
    # Ensure the source directory exists
    if not os.path.isdir(source):
        print(f"Source directory '{source}' does not exist.")
        return

    # Ensure the destination directory exists; create if it doesn't
    if not os.path.isdir(destination):
        print(f"Destination directory '{destination}' does not exist. Creating it...")
        os.makedirs(destination)

    # Iterate through the contents of the source directory
    for item in os.listdir(source):
        source_path = os.path.join(source, item)
        destination_path = os.path.join(destination, item)

        if os.path.isdir(source_path):
            # Copy directories recursively
            if not os.path.exists(destination_path):
                shutil.copytree(source_path, destination_path)
                print(f"Copied directory: {source_path} -> {destination_path}")
        elif os.path.isfile(source_path):
            # Copy files
            shutil.copy2(source_path, destination_path)
            print(f"Copied file: {source_path} -> {destination_path}")

def delete_folders(*paths):

    for path in paths:
        # Check if the folder exists
        if os.path.isdir(path):
            try:
                # Delete the folder
                shutil.rmtree(path)
                print(f"Deleted folder: {path}")
            except Exception as e:
                print(f"Failed to delete folder '{path}': {e}")
        else:
            print(f"Folder '{path}' does not exist.")