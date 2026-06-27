package wom.service.facebook
{
   import flash.utils.ByteArray;
   
   public class FacebookPostRequest
   {
      
      public var boundary:String = "-----";
      
      protected var postData:ByteArray;
      
      public function FacebookPostRequest()
      {
         super();
         createPostData();
      }
      
      public function createPostData() : void
      {
         postData = new ByteArray();
         postData.endian = "bigEndian";
      }
      
      public function writePostData(param1:String, param2:String) : void
      {
         var _loc3_:String = null;
         var _loc5_:Number = NaN;
         writeBoundary();
         writeLineBreak();
         _loc3_ = "Content-Disposition: form-data; name=\"" + param1 + "\"";
         var _loc4_:uint = uint(_loc3_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            postData.writeByte(_loc3_.charCodeAt(_loc5_));
            _loc5_++;
         }
         writeLineBreak();
         writeLineBreak();
         postData.writeUTFBytes(param2);
         writeLineBreak();
      }
      
      public function writeFileData(param1:String, param2:ByteArray, param3:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         writeBoundary();
         writeLineBreak();
         _loc4_ = "Content-Disposition: form-data; name=\"" + param1 + "\"; filename=\"" + param1 + "\";";
         _loc5_ = _loc4_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            postData.writeByte(_loc4_.charCodeAt(_loc6_));
            _loc6_++;
         }
         postData.writeUTFBytes(param1);
         writeQuotationMark();
         writeLineBreak();
         _loc4_ = param3 || "application/octet-stream";
         _loc5_ = _loc4_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            postData.writeByte(_loc4_.charCodeAt(_loc6_));
            _loc6_++;
         }
         writeLineBreak();
         writeLineBreak();
         param2.position = 0;
         postData.writeBytes(param2,0,param2.length);
         writeLineBreak();
      }
      
      public function getPostData() : ByteArray
      {
         postData.position = 0;
         return postData;
      }
      
      public function close() : void
      {
         writeBoundary();
         writeDoubleDash();
      }
      
      protected function writeLineBreak() : void
      {
         postData.writeShort(3338);
      }
      
      protected function writeQuotationMark() : void
      {
         postData.writeByte(34);
      }
      
      protected function writeDoubleDash() : void
      {
         postData.writeShort(11565);
      }
      
      protected function writeBoundary() : void
      {
         var _loc2_:* = 0;
         writeDoubleDash();
         var _loc1_:uint = uint(boundary.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            postData.writeByte(boundary.charCodeAt(_loc2_));
            _loc2_++;
         }
      }
   }
}

