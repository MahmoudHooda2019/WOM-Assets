package wom.view.ui.common
{
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   
   public class MobileMercenaryImageView extends MobileMercenaryButtonView
   {
      
      public function MobileMercenaryImageView(param1:*, param2:UnitTypeDIO, param3:int = 0, param4:int = 0)
      {
         super(param2,param3,param4);
         super.assetRepository = param1;
         super.init();
      }
   }
}

