package feathers.core
{
   public class TokenList
   {
      
      protected var names:Vector.<String> = new Vector.<String>(0);
      
      public function TokenList()
      {
         super();
      }
      
      public function get value() : String
      {
         return names.join(" ");
      }
      
      public function set value(param1:String) : void
      {
         this.names.length = 0;
         this.names = Vector.<String>(param1.split(" "));
      }
      
      public function get length() : int
      {
         return this.names.length;
      }
      
      public function item(param1:int) : String
      {
         if(param1 < 0 || param1 >= this.names.length)
         {
            return null;
         }
         return this.names[param1];
      }
      
      public function add(param1:String) : void
      {
         var _loc2_:int = this.names.indexOf(param1);
         if(_loc2_ >= 0)
         {
            return;
         }
         this.names.push(param1);
      }
      
      public function remove(param1:String) : void
      {
         var _loc2_:int = this.names.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this.names.splice(_loc2_,1);
      }
      
      public function toggle(param1:String) : void
      {
         var _loc2_:int = this.names.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.names.push(param1);
         }
         else
         {
            this.names.splice(_loc2_,1);
         }
      }
      
      public function contains(param1:String) : Boolean
      {
         return this.names.indexOf(param1) >= 0;
      }
   }
}

