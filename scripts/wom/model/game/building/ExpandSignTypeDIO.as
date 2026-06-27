package wom.model.game.building
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import wom.model.component.enum.ActionType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.ConstructableKindTypeDIO;
   import wom.model.domain.domaininfoobject.MultipleInstancePrerequisitesDIO;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.dto.ResourceAmountDTO;
   
   public class ExpandSignTypeDIO extends BuildingTypeDIO
   {
      
      public static const BASE_SIZE:int = 16;
      
      public function ExpandSignTypeDIO()
      {
         var _loc2_:Array = [[]];
         _loc2_[0][1] = [new BuildingTypeVisual("CityExpansionSign",new Point(-23,2),3,true,false,new Point(),"")];
         var _loc1_:Vector.<Number> = new Vector.<Number>();
         _loc1_.push(-1);
         super(100001,new ConstructableKindTypeDIO(2147483647,0,0),16,1,new Vector.<Vector.<ResourceAmountDTO>>(),new Vector.<Number>(),_loc1_,new Vector.<Number>(),1,new Vector.<Vector.<PrerequisiteDIO>>(),new Vector.<Vector.<PrerequisiteDIO>>(),new Vector.<MultipleInstancePrerequisitesDIO>(),new Dictionary(),_loc2_,[],"",BuildMenuCategory.UNKNOWN,ActionType.ENTER_BUILDING,false,"",true,false,0,0,0,new Point(),false,true,0,"",false,-1,new Point());
      }
   }
}

