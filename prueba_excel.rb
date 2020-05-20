require 'spreadsheet'

book = Spreadsheet::Workbook.new
sheet1 = book.create_worksheet

sheet1.row(0).concat %w{Name Age Post}
sheet1.row(1).push 'Charles', '25', 'Designer'
sheet1.row(2).push 'Abbey', '31', 'Developer'
sheet1.row(3).push 'John', '40', 'CEO'

book.write './prueba_excel.xls'