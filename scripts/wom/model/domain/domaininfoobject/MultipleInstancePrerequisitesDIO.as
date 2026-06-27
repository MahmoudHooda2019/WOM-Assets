package wom.model.domain.domaininfoobject
{
   public class MultipleInstancePrerequisitesDIO
   {
      
      private var _prerequisites:Vector.<PrerequisiteDIO>;
      
      private var _maxInstances:int;
      
      public function MultipleInstancePrerequisitesDIO(param1:Vector.<PrerequisiteDIO>, param2:int)
      {
         super();
         _prerequisites = param1;
         _maxInstances = param2;
      }
      
      public function get prerequisites() : Vector.<PrerequisiteDIO>
      {
         return _prerequisites;
      }
      
      public function get maxInstances() : int
      {
         return _maxInstances;
      }
   }
}

