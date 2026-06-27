package wom.model.domain.domaininfoobject
{
   public class EventItemDIO
   {
      
      public var id:int;
      
      public var itemType:int;
      
      public var name:String;
      
      public var assetName:String;
      
      public var relatedId:int;
      
      public var warBuilding:Boolean;
      
      public function EventItemDIO(param1:int, param2:int, param3:String, param4:String, param5:int, param6:Boolean)
      {
         super();
         this.id = param1;
         this.itemType = param2;
         this.name = param3;
         this.assetName = param4;
         this.relatedId = param5;
         this.warBuilding = param6;
      }
   }
}

