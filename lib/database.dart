import 'package:mysql1/mysql1.dart';

class Database{
  static Future<Map<String,dynamic>> getconnection()async{
    Map<String,dynamic> result={
      'connected': false,
      'connection': null,
      'message': '',
    };
    try{
      final conn=await MySqlConnection.connect(ConnectionSettings(
        host: '192.168.1.190',
        port: 3306,
        user: 'root',
        password: '0000',
        db: 'sagemcom',
      ));
    result['connected']=true;
    result['connection']=conn;
    result['message']='connected to mysql database';
    }
    catch(e){
      result['message']='error connection to mysql database $e';
    }
    return result;
  
  }
}