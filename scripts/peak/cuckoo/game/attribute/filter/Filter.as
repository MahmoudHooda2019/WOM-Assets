package peak.cuckoo.game.attribute.filter
{
   public class Filter
   {
      
      public var alpha:Number;
      
      public var color:uint;
      
      public var glow:Boolean;
      
      public function Filter(param1:Number = 1, param2:uint = 16777215, param3:Boolean = false)
      {
         super();
         this.alpha = param1;
         this.color = param2;
         this.glow = param3;
      }
   }
}

