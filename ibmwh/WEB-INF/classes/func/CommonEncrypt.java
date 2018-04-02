package func;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
public class CommonEncrypt {

public static String transMD5(String input)
{
   if(input.equals(""))
    return "";
   String password="";
   //MD5��16λ,SHA��20λ���������ֱ���ժҪ���㷨��
   try {
    //MessageDigest md= MessageDigest.getInstance("MD5");
    MessageDigest md = MessageDigest.getInstance("SHA-1");
    md.update(input.getBytes());
    password=byteToHex(md.digest());
   } catch (NoSuchAlgorithmException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
   }
   return password;
}
private static String byteToHex(byte[] input){
   String password="";
     String stmp="";
     for (int n=0; n<input.length; n++){
         stmp=java.lang.Integer.toHexString(input[n] & 0xFF);
         if (stmp.length()==1) password=password+"0"+stmp;
             else password=password+stmp;
     }
     return password;
}
/**
* @param args
*/
/*public static void main(String[] args) {
   // TODO Auto-generated method stub
   System.out.println(transMD5("wap@lib.bnu.edu.cn"));
   System.out.println(transMD5("123456"));
}*/
}
