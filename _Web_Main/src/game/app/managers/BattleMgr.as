package game.app.managers
{
	import common.base.managers.BaseMgr;
	
	import game.core.interfaces.IMapView;
	import game.core.interfaces.IPeopleModel;
	import game.untils.INode;
	import game.untils.QuadNode;
	
	import starling.events.Event;

	/**
	 * 战斗管理器 
	 * @author noah
	 * 
	 */	
	public class BattleMgr extends BaseMgr
	{
		/**
		 *单例模式 
		 */		
		private static var _instance:BattleMgr;
		/**
		 * 单例访问器
		 * @return 
		 */		
		public static function get instance():BattleMgr {
			if(_instance == null) {
				_instance = new BattleMgr();
			}
			return _instance;
		}
		
		/**
		 * 
		 */		
		public function BattleMgr()
		{
			if(_instance != null){
				throw new Error("该类是单例模式");
			}
			_instance = this;
		}
		/**
		 * 近战攻击
		 * @param p
		 * @param map
		 */		
		public function attack( p:IPeopleModel, map:IMapView ):void{
			
//			var tempDir:uint = p.dir % 8;
//			if(tempDir == 0){
//				tempDir = 8
//			}
//			p.dir = tempDir + 24;
//			p.isGCD = true;
//			p.isAniPlaying = true;
//			//显示周围九格的怪物和玩家
//			showBlocks( p, map );
//			
//			var i:uint = setTimeout(function():void{
//				clearTimeout( i );
//				p.isAniPlaying = false;
//				p.isGCD = false;
//				p.dir = tempDir;
//			}, PeopleModel.GCD_TIME);
			
		}
		
		private var _map:IMapView;
		/**
		 * 远程攻击
		 * @param p
		 * @param map
		 */		
		public function cast( p:IPeopleModel, map:IMapView ):void{
			
//			return;
//			
//			_map = map;
//			var tempDir:uint = p.dir % 8;
//			if(tempDir == 0){
//				tempDir = 8
//			}
//			p.dir = tempDir + 24;
//			p.isGCD = true;
//			p.isAniPlaying = true;
//			
//			var skillBall:SkillBallView3D;
//			if(RpgMain.GAME_MODE == 1){
//				skillBall = new SkillBallView3D();
//			} else if(RpgMain.GAME_MODE == 2 || RpgMain.GAME_MODE == 3){
//				skillBall = new TileSkillBallView3D();
//			}
//			skillBall.init([p.modX, p.modY, 3]);
//			trace("[BattleMgr] " + p.gridX, p.gridY);
//			skillBall.model.dir = tempDir + 8;
//			skillBall.draw();
//			skillBall.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
//			Display3DMgr.getStage.addChild( skillBall );
//			
//			TextTool.setText(5, "" + p.modX + "," + p.modY + skillBall.model.modX + "," + skillBall.model.modY);
//			
//			/*var fire:TestFireBall = new TestFireBall( tempDir );
//			fire.x = p.posX + 10;
//			fire.y = p.posY + 40;
//			DisplayMgr.getStage.addChild(fire);*/
//			
//			var i:uint = setTimeout(function():void{
//				clearTimeout( i );
//				p.isAniPlaying = false;
//				p.isGCD = false;
//				p.dir = tempDir;
//			}, PeopleModel.GCD_TIME);
		}
		
		protected function onEnterFrameHandler(event:Event):void
		{
//			var skillBall:SkillBallView3D = event.currentTarget as SkillBallView3D;
//			if(skillBall.hasRemoved){
//				skillBall.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
//			} else {
//				skillBall.onInputHandler( _map );
//			}
		}
		
		private var peopleModel:IPeopleModel;
		
		private function showBlocks( p:IPeopleModel, map:IMapView ):void {
			/*
			-1,-1 0,-1 1,-1
			-1,0  0,0  1,0
			-1,1  0,1  1,1
			*/
			
//			peopleModel = p;
//			
//			var node1:QuadNode;
//			var node2:QuadNode;
//			var node3:QuadNode;
//			var node4:QuadNode;
//			node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY-1)) as QuadNode;
//			node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY-1)) as QuadNode;
//			node3 = map.objTree.nodes.get( (p.gridX+1) + "-" + (p.gridY-1)) as QuadNode;
//			var str1:String = node1.objVec.length.toString() + node2.objVec.length.toString() + node3.objVec.length.toString() ;
//			node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + p.gridY) as QuadNode;
//			node2 = map.objTree.nodes.get( p.gridX + "-" + p.gridY) as QuadNode;
//			node4 = node2;
//			node3 = map.objTree.nodes.get( (p.gridX+1) + "-" + p.gridY) as QuadNode;
//			var str2:String = node1.objVec.length.toString() + node2.objVec.length.toString() + node3.objVec.length.toString() ;
//			node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY+1)) as QuadNode;
//			node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY+1)) as QuadNode;
//			node3 = map.objTree.nodes.get((p.gridX+1) + "-" + (p.gridY+1)) as QuadNode;
//			var str3:String = node1.objVec.length.toString() + node2.objVec.length.toString() + node3.objVec.length.toString() ;
//			
//			TextTool.setText(1, str1);
//			TextTool.setText(2, str2);
//			TextTool.setText(3, str3 + " " + p.dir);
//			
//			//对八方向分别进行攻击判定
//			if(p.dir % 8 == 1){
//				node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY+1)) as QuadNode;
//				node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY+1)) as QuadNode;
//				node3 = map.objTree.nodes.get((p.gridX+1) + "-" + (p.gridY+1)) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} else if(p.dir % 8 == 2){
//				node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY+1)) as QuadNode;
//				node3 = map.objTree.nodes.get((p.gridX+1) + "-" + (p.gridY+1)) as QuadNode;
//				node1 = map.objTree.nodes.get( (p.gridX+1) + "-" + p.gridY) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} else if(p.dir % 8 == 3){
//				node1 = map.objTree.nodes.get( (p.gridX+1) + "-" + (p.gridY-1)) as QuadNode;
//				node2 = map.objTree.nodes.get( (p.gridX+1) + "-" + p.gridY) as QuadNode;
//				node3 = map.objTree.nodes.get((p.gridX+1) + "-" + (p.gridY+1)) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} else if(p.dir % 8 == 4){
//				node1 = map.objTree.nodes.get( (p.gridX+1) + "-" + p.gridY) as QuadNode;
//				node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY-1)) as QuadNode;
//				node3 = map.objTree.nodes.get( (p.gridX+1) + "-" + (p.gridY-1)) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} else if(p.dir % 8 == 5){
//				node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY-1)) as QuadNode;
//				node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY-1)) as QuadNode;
//				node3 = map.objTree.nodes.get( (p.gridX+1) + "-" + (p.gridY-1)) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} else if(p.dir % 8 == 6){
//				node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY-1)) as QuadNode;
//				node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY-1)) as QuadNode;
//				node3 = map.objTree.nodes.get( (p.gridX-1) + "-" + p.gridY) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} else if(p.dir % 8 == 7){
//				node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY-1)) as QuadNode;
//				node2 = map.objTree.nodes.get( (p.gridX-1) + "-" + p.gridY) as QuadNode;
//				node3 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY+1)) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} else if(p.dir % 8 == 0){
//				node3 = map.objTree.nodes.get( (p.gridX-1) + "-" + p.gridY) as QuadNode;
//				node1 = map.objTree.nodes.get( (p.gridX-1) + "-" + (p.gridY+1)) as QuadNode;
//				node2 = map.objTree.nodes.get( p.gridX + "-" + (p.gridY+1)) as QuadNode;
//				blockAttack( node1, node2, node3, node4);
//			} 
		}
		
		private function blockAttack(node1:QuadNode, node2:QuadNode, node3:QuadNode, node4:QuadNode):void
		{
//			vecAtk( node1.objVec );
//			vecAtk( node2.objVec );
//			vecAtk( node3.objVec );
//			vecAtk( node4.objVec );
			//trace(node1.objVec.length.toString() + node2.objVec.length.toString() + node3.objVec.length.toString());
		}
		
		private function vecAtk(objVec:Vector.<INode>):void
		{
//			for each(var n:INode in objVec){
//				if(n is TileMonsterView3D){
//					(n.model as TileMonsterModel).heated( peopleModel );
//				} else if(n is MonsterView3D){
//					(n.model as MonsterModel).heated( peopleModel );
//				}
//			}
		}
	}
}