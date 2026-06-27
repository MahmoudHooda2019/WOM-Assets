package wom.controller.command.ui
{
   import peak.display.ExternalTextInputEvent;
   import peak.display.TextInputDTO;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   
   public class TextInputResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      public function TextInputResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc4_:TextInputDTO = null;
         var _loc2_:Object = null;
         try
         {
            _loc2_ = PJSON.decode(String(event.response));
         }
         catch(e:Error)
         {
            log(LoggerContexts.UNEXPECTED,"Unexpected response from textInputResponse",event.response);
         }
         if(_loc2_ != null)
         {
            _loc1_ = "id" in _loc2_ && _loc2_.id != null ? String(_loc2_.id) : "";
            _loc3_ = "text" in _loc2_ && _loc2_.text != null ? String(_loc2_.text) : "";
            _loc4_ = new TextInputDTO(_loc1_,_loc3_);
            dispatch(new ExternalTextInputEvent("externalTextInputUpdated",_loc4_));
         }
      }
   }
}

