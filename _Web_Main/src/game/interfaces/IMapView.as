package  game.interfaces
{
	import game.untils.QuadTrees;
	
	public interface IMapView
	{
		function addMonster(p:IObjectView):void;
		function addPlayer(p:IObjectView):void;
		function init( data:Object = null ):void;	
		function get model():IMapModel;
		function set model(value:IMapModel):void;
		function get objTree():QuadTrees;
		function getBlocks( pArr:Array):Array;
	}
}