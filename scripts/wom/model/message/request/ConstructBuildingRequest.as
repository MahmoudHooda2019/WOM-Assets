package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ConstructBuildingRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _buildingTypeId:int;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _byGold:Boolean;
      
      private var _completeResources:Boolean;
      
      public function ConstructBuildingRequest(param1:int, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         _buildingTypeId = param1;
         _x = param2;
         _y = param3;
         _byGold = param4;
         _completeResources = param5;
      }
      
      override public function serialize() : Object
      {
         if(_byGold)
         {
            return {
               "buildingTypeId":_buildingTypeId,
               "position":{
                  "x":_x,
                  "y":_y
               },
               "byGold":_byGold
            };
         }
         if(_completeResources)
         {
            return {
               "buildingTypeId":_buildingTypeId,
               "position":{
                  "x":_x,
                  "y":_y
               },
               "completeResources":_completeResources
            };
         }
         return {
            "buildingTypeId":_buildingTypeId,
            "position":{
               "x":_x,
               "y":_y
            }
         };
      }
   }
}

