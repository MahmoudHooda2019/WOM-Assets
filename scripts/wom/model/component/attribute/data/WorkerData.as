package wom.model.component.attribute.data
{
   import wom.model.domain.domaininfoobject.WorkerTypeDIO;
   
   public class WorkerData extends UnitData
   {
      
      public var workerTypeDIO:WorkerTypeDIO;
      
      public function WorkerData(param1:WorkerTypeDIO)
      {
         super(null,null,null,false);
         this.workerTypeDIO = param1;
         var _temp_1:* = speed;
         var _loc3_:Number = 0.2;
         var _loc2_:WorkerThread = _temp_1;
         _loc2_._value = _loc3_;
      }
      
      override public function init() : void
      {
         initialized = true;
      }
      
      override public function get levelIndex() : int
      {
         return 0;
      }
      
      override public function calculateStats() : void
      {
      }
      
      override protected function calculateRange() : void
      {
      }
   }
}

