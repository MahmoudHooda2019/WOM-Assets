package peak.display
{
   import flash.events.Event;
   
   public class ExternalTextInputEvent extends Event
   {
      
      public static const UPDATED:String = "externalTextInputUpdated";
      
      private var _textInputDTO:TextInputDTO;
      
      public function ExternalTextInputEvent(param1:String, param2:TextInputDTO)
      {
         super(param1);
         _textInputDTO = param2;
      }
      
      override public function clone() : Event
      {
         return new ExternalTextInputEvent(type,_textInputDTO);
      }
      
      public function get textInputDTO() : TextInputDTO
      {
         return _textInputDTO;
      }
   }
}

