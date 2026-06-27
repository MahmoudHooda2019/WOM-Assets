package wom.model.game.speech
{
   import peak.i18n.PText;
   
   public class SpeechType
   {
      
      public static const WORKER_CONSTRUCTION_START:SpeechType = new SpeechType(0,"workerconstructionstart",2);
      
      public static const WORKER_UPGRADE_START:SpeechType = new SpeechType(1,"workerupgradestart",1);
      
      public static const WORKER_FORTIFY_START:SpeechType = new SpeechType(2,"workerfortifystart",1);
      
      public static const WORKER_IDLE:SpeechType = new SpeechType(3,"workeridle",8);
      
      public static var speechTypes:Array = [WORKER_CONSTRUCTION_START,WORKER_UPGRADE_START,WORKER_FORTIFY_START,WORKER_IDLE];
      
      private var _id:int;
      
      private var _key:String;
      
      private var _count:int;
      
      public function SpeechType(param1:int, param2:String, param3:int)
      {
         super();
         _id = param1;
         _key = param2;
         _count = param3;
      }
      
      public function getText(param1:int) : String
      {
         var _loc2_:String = "speech." + _key + "." + param1;
         return peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get count() : int
      {
         return _count;
      }
   }
}

