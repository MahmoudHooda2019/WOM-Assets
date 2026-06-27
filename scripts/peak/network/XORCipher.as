package peak.network
{
   import flash.utils.ByteArray;
   
   public class XORCipher implements Cipher
   {
      
      private var _encodingKeyList:Vector.<uint>;
      
      private var _decodingKeyList:Vector.<uint>;
      
      private var _encodingKey:String;
      
      private var _decodingKey:String;
      
      private var encodeKeyIndex:uint;
      
      private var decodeKeyIndex:uint;
      
      public function XORCipher(param1:String = "0123456789", param2:String = "0123456789")
      {
         super();
         _encodingKey = param1;
         _decodingKey = param2;
         resetCipher();
      }
      
      public function encodeBytes(param1:ByteArray) : ByteArray
      {
         var _loc2_:* = 0;
         var _loc3_:ByteArray = new ByteArray();
         while(param1.bytesAvailable > 0)
         {
            _loc2_ = param1.readUnsignedByte();
            _loc3_.writeByte(encodeByte(_loc2_));
         }
         return _loc3_;
      }
      
      public function encodeByte(param1:uint) : uint
      {
         var _loc2_:uint = uint(param1 ^ _encodingKeyList[encodeKeyIndex]);
         moveEncodingIndexForward(_loc2_);
         return _loc2_;
      }
      
      private function moveEncodingIndexForward(param1:uint) : void
      {
         if(++encodeKeyIndex == _encodingKeyList.length)
         {
            encodeKeyIndex = 0;
         }
         var _loc2_:uint = encodeKeyIndex;
         var _loc3_:int = _encodingKeyList[_loc2_] ^ param1;
         _encodingKeyList[_loc2_] = _loc3_;
      }
      
      public function decodeBytes(param1:ByteArray) : ByteArray
      {
         var _loc3_:* = 0;
         var _loc2_:ByteArray = new ByteArray();
         while(param1.bytesAvailable > 0)
         {
            _loc3_ = param1.readUnsignedByte();
            _loc2_.writeByte(decodeByte(_loc3_));
         }
         return _loc2_;
      }
      
      public function decodeByte(param1:uint) : uint
      {
         var _loc2_:uint = uint(param1 ^ _decodingKeyList[decodeKeyIndex]);
         moveDecodingIndexForward(param1);
         return _loc2_;
      }
      
      private function moveDecodingIndexForward(param1:uint) : void
      {
         if(++decodeKeyIndex == _decodingKeyList.length)
         {
            decodeKeyIndex = 0;
         }
         var _loc2_:uint = decodeKeyIndex;
         var _loc3_:int = _decodingKeyList[_loc2_] ^ param1;
         _decodingKeyList[_loc2_] = _loc3_;
      }
      
      public function resetCipher() : void
      {
         var _loc1_:int = 0;
         encodeKeyIndex = 0;
         decodeKeyIndex = 0;
         _encodingKeyList = new Vector.<uint>();
         _decodingKeyList = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < _encodingKey.length)
         {
            _encodingKeyList[_loc1_] = _encodingKey.charCodeAt(_loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _decodingKey.length)
         {
            _decodingKeyList[_loc1_] = _decodingKey.charCodeAt(_loc1_);
            _loc1_++;
         }
      }
   }
}

