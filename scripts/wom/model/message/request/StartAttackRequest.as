package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import wom.model.game.Profile;
   
   public class StartAttackRequest extends AbstractOutgoingMessage
   {
      
      private var _profile:Profile;
      
      private var _version:int;
      
      public function StartAttackRequest(param1:Profile, param2:int = -1)
      {
         super();
         _profile = param1;
         _version = param2;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {};
         if(_profile.isNpc)
         {
            _loc1_.defenderNpcName = _profile.npcId;
         }
         else
         {
            _loc1_.defenderGameUid = _profile.gameId;
         }
         if(_version != -1)
         {
            _loc1_.version = _version;
         }
         return _loc1_;
      }
   }
}

