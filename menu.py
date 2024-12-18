import os
import subprocess
import shutil

from utilities import copy_files, delete_folders, execute

main_dir = "d:/frencircle"
ui_path = "d:/frencircle/UI"
api_path = "d:/frencircle/API"
release_path = "d:/releases/frencircle"

def cleaning():
    delete_folders(
                'release',
                'UI/dist', 
                'API/API.Base/obj', 
                'API/API.Base/bin',
                'API/API.Entities/bin',
                'API/API.Entities/obj',
                'API/API.Infra/bin',
                'API/API.Infra/obj',
                'API/API.Repositories/bin',
                'API/API.Repositories/obj',
                'API/API.Validators/bin',
                'API/API.Validators/obj'
                )

def display_menu():
    while True:
        os.chdir(main_dir)
        print("\n")
        print("|============= MENU =============|")
        print("|    1. Build .NET Project       |")
        print("|    2. Build Angular            |")
        print("|    3. CleanUp                  |")
        print("|    4. Release                  |")
        print("|    5. Exit                     |")
        print("|================================|")

        choice = input("Enter your choice: ").strip()
        
        if choice == "1":
            print("building api")
            execute("dotnet publish -r win-x64 --self-contained false -c Release" , api_path)
            break
            
        elif choice == "2":
            print("building UI.")
            execute("ng build",ui_path)
            break
            
        elif choice == "3": 
            print("Cleaning up.")
            cleaning()
            break

        elif choice == "4":
            print("initiating release.")
            cleaning()

            print("build api publish files")
            execute("dotnet publish -r win-x64 --self-contained false -c Release" , api_path)
            
            print("build UI publish files")
            execute("ng build",ui_path)

            print("copying to release directory.")
            copy_files(ui_path +"/dist/ui/browser", release_path + "/wwwroot")
            copy_files(api_path + "/API.Base/bin/Release/net8.0/win-x64/publish",release_path)

            print("creating ftp connection.")
            break
            
        elif choice == "5":
            print("Exiting the menu.")
            break
        else:
            print("Invalid choice. Please try again.")

# Execute the CLI menu
if __name__ == "__main__":
    display_menu()