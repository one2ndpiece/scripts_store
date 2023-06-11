import os

def count_files_in_directory(directory_path):
    if not os.path.exists(directory_path):
        raise ValueError(f"ディレクトリが存在しません: {directory_path}")

    if not os.path.isdir(directory_path):
        raise ValueError(f"指定されたパスはディレクトリではありません: {directory_path}")

    file_count = 0

    for entry in os.scandir(directory_path):
        if entry.is_file():
            file_count += 1

    return file_count

if __name__ == "__main__":
    directory_path = input("ディレクトリのパスを入力してください: ")
    
    try:
        file_count = count_files_in_directory(directory_path)
        print(f"{directory_path} 内のファイル数: {file_count}")
    except ValueError as error:
        print(error)
