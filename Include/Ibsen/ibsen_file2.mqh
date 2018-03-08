
int file_handle_w_ibsen = -1;

void File_Init_ibsen()
{
    ResetLastError();
       file_handle_w_ibsen=FileOpen("fractals.csv",FILE_WRITE|FILE_CSV);
       if(file_handle_w_ibsen!=INVALID_HANDLE)
         {
          FileWrite(file_handle_w_ibsen,TimeCurrent(),Symbol(), EnumToString(_Period));
          FileClose(file_handle_w_ibsen);
          Print("FileOpen OK");
         }
            else Print("Opera