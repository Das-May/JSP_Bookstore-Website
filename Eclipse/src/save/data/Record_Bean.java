package save.data;
public class Record_Bean{
   String [][] tableRecord=null;   //��Ų�ѯ���ļ�¼��
   int totalRecords ;             //ȫ����¼��
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
