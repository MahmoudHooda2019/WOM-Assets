package wom.controller.command
{
   import flash.utils.Dictionary;
   import peak.messaging.DefaultIncomingMessageMap;
   import wom.model.game.attack.GameModeType;
   
   public class WomIncomingMessageMap extends DefaultIncomingMessageMap
   {
      
      private var typeToGameModeTypesMap:Dictionary;
      
      private const defaultGameTypesArray:Array = [GameModeType.NORMAL];
      
      public function WomIncomingMessageMap()
      {
         super();
         this.typeToGameModeTypesMap = new Dictionary();
      }
      
      private static function createDictionary(param1:Array) : Dictionary
      {
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc2_ in param1)
         {
            _loc3_[_loc2_.id] = true;
         }
         return _loc3_;
      }
      
      public function mapWomMessage(param1:*, param2:Class, param3:Array = null) : void
      {
         super.mapMessage(param1,param2);
         if(!param3)
         {
            param3 = defaultGameTypesArray;
         }
         typeToGameModeTypesMap[param1] = createDictionary(param3);
      }
      
      public function hasGameModeTypeForMessageType(param1:*, param2:GameModeType) : Boolean
      {
         return param2.id in getGameModeTypeForMessageType(param1);
      }
      
      public function hasGameModeTypeDictionaryForType(param1:*) : Boolean
      {
         return param1 in typeToGameModeTypesMap;
      }
      
      public function getGameModeTypeForMessageType(param1:*) : Dictionary
      {
         return typeToGameModeTypesMap[param1];
      }
   }
}

