import os
import pandas as pd

def read_txt_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
        data = [line.strip().split(',') for line in lines]
    return data

def convert_to_number(value):
    try:
        return int(value)
    except ValueError:
        try:
            return float(value)
        except ValueError:
            return value

def create_dataframe(data):
    headers = data[0]
    values = [[convert_to_number(cell) for cell in row] for row in data[1:]]
    df = pd.DataFrame(values, columns=headers)
    return df

def export_to_excel(df, output_path):
    with pd.ExcelWriter(output_path) as writer:
        df.to_excel(writer, index=False, sheet_name='Sheet1')

def main():
    input_directory = 'D:\Dドキュメント\業務\D棟\参考資料\稼働実績ログ\M棟の実ログコピー\programtest2\WLog\WLog_R2'
    output_directory = 'D:\Dドキュメント\業務\D棟\参考資料\稼働実績ログ\M棟の実ログコピー\programtest2\WLog\WLog_R2\excelLog'

    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    for filename in os.listdir(input_directory):
        if filename.endswith('.log'):
            input_file_path = os.path.join(input_directory, filename)
            output_file_path = os.path.join(output_directory, filename.replace('.log', '.xlsx'))

            data = read_txt_file(input_file_path)
            df = create_dataframe(data)
            export_to_excel(df, output_file_path)

if __name__ == '__main__':
    main()
