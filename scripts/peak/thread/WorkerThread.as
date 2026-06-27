package peak.thread
{
   public class WorkerThread
   {
      
      private var _value:Number;
      
      public function WorkerThread(param1:Number = 0)
      {
         super();
         _value = param1;
      }
      
      final public function get value() : Number
      {
         return _value;
      }
      
      final public function set value(param1:Number) : void
      {
         _value = param1;
      }
   }
}

