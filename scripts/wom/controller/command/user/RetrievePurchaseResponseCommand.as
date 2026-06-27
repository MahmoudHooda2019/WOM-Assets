package wom.controller.command.user
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.UserInfo;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.screen.popups.gold.WeAreRichPopUp;
   
   public class RetrievePurchaseResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function RetrievePurchaseResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:Object = null;
         var _loc3_:Number = NaN;
         var _loc1_:Object = null;
         try
         {
            _loc1_ = PJSON.decode(String(event.response));
         }
         catch(e:Error)
         {
            log(LoggerContexts.UNEXPECTED,"Unexpected response from purchaseResponse",event.response);
         }
         dispatch(new PopUpWindowEvent("showPopUpWindow",new WeAreRichPopUp(),0,null,null,false,userInfo.delayPopups));
         if(_loc1_ != null && "k" in _loc1_ && _loc1_.k != null && (!("t" in _loc1_) || _loc1_.t == null || _loc1_.t != "true"))
         {
            _loc2_ = _loc1_.k;
            _loc3_ = documentConfiguration.getParameter("kid") != null ? documentConfiguration.getParameter("kid") : 1;
            kontagentApi.trackRevenue(_loc3_,_loc2_.v,{
               "subtype1":_loc2_.st1,
               "subtype2":_loc2_.st2,
               "data":_loc2_.data
            });
         }
      }
   }
}

