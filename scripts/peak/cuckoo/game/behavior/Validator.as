package peak.cuckoo.game.behavior
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   
   public class Validator extends Behavior
   {
      
      public static const TYPE_ID:String = "Validator";
      
      public var head:GameSprite;
      
      public var allInvalidated:Boolean = true;
      
      public function Validator()
      {
         super();
         priority = 1;
      }
      
      override public function get typeId() : String
      {
         return "Validator";
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override public function destroy() : void
      {
         disable();
      }
      
      override public function update() : void
      {
         var _loc3_:GameSprite = head;
         if(allInvalidated)
         {
            for each(var _loc2_ in owner.root.layers)
            {
               for each(var _loc1_ in _loc2_.allChildrenContainer.children)
               {
                  if(!_loc1_.composite || _loc1_.composite == _loc1_)
                  {
                     _loc1_.bounds.update();
                  }
               }
            }
            while(_loc3_)
            {
               _loc3_.invalidated = false;
               _loc3_ = _loc3_.nextInvalidated;
            }
            allInvalidated = false;
         }
         else
         {
            while(_loc3_)
            {
               try
               {
                  _loc3_.bounds.update();
               }
               catch(e:Error)
               {
               }
               _loc3_.invalidated = false;
               _loc3_ = _loc3_.nextInvalidated;
            }
         }
         head = null;
      }
      
      public function add(param1:GameSprite) : void
      {
         if(param1.composite)
         {
            param1 = param1.composite;
         }
         if(param1.invalidated)
         {
            return;
         }
         param1.nextInvalidated = head;
         head = param1;
         param1.invalidated = true;
      }
   }
}

