package wom.model.message.notification
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   import wom.model.game.watchpost.WatchpostHelpInfo;
   import wom.model.game.watchpost.WatchpostHelpedFriendDTO;
   
   public class FriendWatchpostHelpNotification extends AbstractIncomingMessage
   {
      
      private var _helpInfo:WatchpostHelpInfo;
      
      public function FriendWatchpostHelpNotification()
      {
         super();
      }
      
      public static function deserializeHelpedFriend(param1:Object, param2:Vector.<WatchpostHelpedFriendDTO>) : void
      {
         var _loc5_:Profile = null;
         var _loc3_:Dictionary = null;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         if(param1 != null && "deployingUser" in param1 && "unitAmounts" in param1)
         {
            _loc5_ = new Profile(param1.deployingUser[0],param1.deployingUser[1],param1.deployingUser[2]);
            _loc3_ = new Dictionary();
            _loc7_ = false;
            for each(var _loc4_ in param2)
            {
               if(_loc4_.friendProfile.gameId == _loc5_.gameId)
               {
                  _loc3_ = _loc4_.helpedUnits;
                  _loc7_ = true;
                  break;
               }
            }
            for each(var _loc6_ in param1.unitAmounts)
            {
               _loc8_ = int(_loc6_["id"]);
               if(!(_loc8_ in _loc3_))
               {
                  _loc3_[_loc8_] = 0;
               }
               var _loc10_:int = _loc8_;
               var _loc9_:Number = _loc3_[_loc10_] + _loc6_["amount"];
               _loc3_[_loc10_] = _loc9_;
            }
            if(!_loc7_)
            {
               param2.push(new WatchpostHelpedFriendDTO(_loc5_,_loc3_));
            }
         }
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Vector.<WatchpostHelpedFriendDTO> = new Vector.<WatchpostHelpedFriendDTO>();
         deserializeHelpedFriend(param1,_loc2_);
         _helpInfo = new WatchpostHelpInfo(_loc2_);
      }
      
      public function get helpInfo() : WatchpostHelpInfo
      {
         return _helpInfo;
      }
   }
}

