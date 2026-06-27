package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.SwearFilterLanguageDTO;
   
   public class ChatAuthResponse extends AbstractIncomingMessage
   {
      
      protected var _resultCode:int;
      
      protected var _success:Boolean;
      
      private var _remainingDuration:Number;
      
      private var _swearFilterLanguageDTO:SwearFilterLanguageDTO;
      
      public function ChatAuthResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         _resultCode = param1.resultCode;
         _success = param1.success;
         _remainingDuration = param1["remainingDuration"];
         if("remainingDuration" in param1 && param1.remainingDuration != null)
         {
            _remainingDuration = param1["remainingDuration"];
         }
         else
         {
            _remainingDuration = -1;
         }
         _swearFilterLanguageDTO = null;
         if("filteredWords" in param1 && param1["filteredWords"] != null)
         {
            _loc4_ = param1["filteredWords"];
            _loc2_ = new Vector.<String>();
            _loc3_ = new Vector.<String>();
            fillWordList(_loc4_["wholeWords"],_loc2_);
            fillWordList(_loc4_["insideWords"],_loc3_);
            _swearFilterLanguageDTO = new SwearFilterLanguageDTO(_loc4_["lang"],_loc2_,_loc3_);
         }
      }
      
      private function fillWordList(param1:Array, param2:Vector.<String>) : void
      {
         for each(var _loc3_ in param1)
         {
            param2.push(_loc3_);
         }
      }
      
      public function get swearFilterLanguageDTO() : SwearFilterLanguageDTO
      {
         return _swearFilterLanguageDTO;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
   }
}

