package wom.controller.command.user
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.AnnouncementInfo;
   import wom.view.screen.windows.announcement.MobileAnnouncementWindow;
   
   public class RetrieveAnnouncementsResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function RetrieveAnnouncementsResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc7_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:AnnouncementInfo = null;
         var _loc5_:* = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         try
         {
            _loc4_ = event.response;
         }
         catch(e:Error)
         {
            log(LoggerContexts.UNEXPECTED,"Unexpected response from announcementsResponse",event.response);
         }
         if(_loc4_ != null)
         {
            documentConfiguration.announcements.length = 0;
            _loc7_ = new Vector.<AnnouncementInfo>();
            _loc6_ = new Vector.<AnnouncementInfo>();
            for each(var _loc1_ in _loc4_)
            {
               if("id" in _loc1_ && _loc1_.id != null && "image" in _loc1_ && _loc1_.image != null && "title" in _loc1_ && _loc1_.title != null && "text" in _loc1_ && _loc1_.text != null && "seen" in _loc1_ && _loc1_.seen != null && "priority" in _loc1_ && _loc1_.priority)
               {
                  _loc2_ = new AnnouncementInfo(String(_loc1_.id),String(_loc1_.title),String(_loc1_.image),String(_loc1_.text),int(_loc1_.priority),Boolean(_loc1_.seen));
                  if(_loc2_.seen)
                  {
                     _loc5_ = 0;
                     while(_loc5_ < _loc7_.length)
                     {
                        if(_loc2_.priority <= _loc7_[_loc5_].priority)
                        {
                           break;
                        }
                        _loc5_++;
                     }
                     _loc7_.splice(_loc5_,0,_loc2_);
                  }
                  else
                  {
                     _loc5_ = 0;
                     while(_loc5_ < _loc6_.length)
                     {
                        if(_loc2_.priority <= _loc6_[_loc5_].priority)
                        {
                           break;
                        }
                        _loc5_++;
                     }
                     _loc6_.splice(_loc5_,0,_loc2_);
                  }
               }
            }
            _loc3_ = _loc6_.length > 0;
            documentConfiguration.announcements = _loc6_.concat(_loc7_);
            if(_loc3_)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAnnouncementWindow(documentConfiguration.announcements)));
            }
         }
      }
   }
}

