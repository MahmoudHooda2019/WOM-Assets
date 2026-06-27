package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.helper.RowColumnPair;
   
   public class CityDimensionsUpdatedEventNotification extends AbstractIncomingMessage
   {
      
      private var _dimensions:RowColumnPair;
      
      public function CityDimensionsUpdatedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _dimensions = new RowColumnPair(param1.dimensions.numberOfRows,param1.dimensions.numberOfColumns);
      }
      
      public function get dimensions() : RowColumnPair
      {
         return _dimensions;
      }
   }
}

