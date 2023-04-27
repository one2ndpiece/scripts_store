import os

def get_files_with_size(path):
    file_list = []

    for root, _, files in os.walk(path):
        for file in files:
            file_path = os.path.join(root, file)
            try:
                file_size = os.path.getsize(file_path)
                file_list.append((file_path, file_size))
            except FileNotFoundError:
                pass

    return file_list

def main():
    path = 'C:\\'  # Cドライブを指定
    files_with_size = get_files_with_size(path)

    # 容量が大きい順にソート
    sorted_files = sorted(files_with_size, key=lambda x: x[1], reverse=True)

    # 容量が大きい上位10ファイルを表示
    for i, (file, size) in enumerate(sorted_files[:100]):
        print(f"{i + 1}. {file} ({size / (1024 * 1024):.2f} MB)")

if __name__ == "__main__":
    main()
