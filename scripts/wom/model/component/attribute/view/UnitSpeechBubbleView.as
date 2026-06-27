package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.view.BaseView;
   
   public class UnitSpeechBubbleView extends BaseView
   {
      
      private var _id:int;
      
      private var _index:int;
      
      private var ownerPosition:Position;
      
      public function UnitSpeechBubbleView(param1:int, param2:int)
      {
         super(4);
         _id = param1;
         _index = param2;
      }
      
      override public function init() : void
      {
         super.init();
      }
   }
}

