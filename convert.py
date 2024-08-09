import pandas as pd
import os

def convert_excel_to_csv(folder_path):
    # List all files in the folder
    for filename in os.listdir(folder_path):
        # Check if the file is an Excel file
        if filename.endswith('.xlsx') or filename.endswith('.xls'):
            file_path = os.path.join(folder_path, filename)
            # Load the Excel file
            excel_data = pd.read_excel(file_path, sheet_name=None)
            
            # Loop through each sheet in the Excel file
            for sheet_name, data in excel_data.items():
                # Create a CSV file name
                csv_filename = f"{os.path.splitext(filename)[0]}_{sheet_name}.csv"
                csv_file_path = os.path.join(folder_path, csv_filename)
                
                # Save the data to a CSV file
                data.to_csv(csv_file_path, index=False)
                print(f"Converted {file_path} (sheet: {sheet_name}) to {csv_file_path}")

if __name__ == "__main__":
    # Set the folder path to the directory containing your Excel files
    folder_path = './data/'
    
    # Call the conversion function
    convert_excel_to_csv(folder_path)

#['customers_Sheet1.csv', 'detail_status_rekening_Sheet1.csv',
# 'lokasi_unit_Sheet1.csv', 'master_data_pinjaman_Sheet1.csv',
# 'master_data_tabungan_Sheet1.csv', 'saldo_sisa_tabungan_Sheet1.csv',
# 'transaksi_simpanan_Sheet1.csv']
