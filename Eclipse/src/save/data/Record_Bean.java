package save.data;
public class Record_Bean{
   String [][] tableRecord=null;   //存放查询到的记录。
   int totalRecords ;             //全部记录。
   public void setTableRecord(String [][] s){
      tableRecord=s;
   }
   public String [][] getTableRecord(){
      return tableRecord;
   }
   
    public int getTotalRecords(){
      totalRecords = tableRecord.length;
      return totalRecords ;
   }
}
