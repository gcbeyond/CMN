#import "Graph.h"


@implementation Graph

-(id)init
{
	self = [super init];
	edgeCount = 0;
	vertexCount = 0;
	selectedVertex = -1;
	for (int i = 0; i < MAX_VERTEX_COUNT; i++) 
	{
		connectedVertices[i] = 0;
	}
	for (int i = 0 ; i < MAX_EDGE_COUNT ; i++) 
	{
		numberOfIntersectionsForEdge[i] = 0;
	}
	return self;
}

-(Boolean)lineIntersect:(CGPoint)a1 Point2:(CGPoint)a2 Point3:(CGPoint)b1 Point4:(CGPoint)b2
{
		//----------------------------------------------------------------------
    
    float	a1yb1y, a1xb1x, a2xa1x, a2ya1y;
    float	crossa, crossb;
	
		//----------------------------------------------------------------------
	
    a1yb1y = a1.y-b1.y;
    a1xb1x = a1.x-b1.x;
    a2xa1x = a2.x-a1.x;
    a2ya1y = a2.y-a1.y;
	
		//----------------------------------------------------------------------
	
    crossa = a1yb1y * ( b2.x - b1.x ) - a1xb1x * ( b2.y - b1.y );
    crossb = a2xa1x * ( b2.y - b1.y ) - a2ya1y * ( b2.x - b1.x );
	
		//----------------------------------------------------------------------
    
    if ( crossb == 0 )
    {
		return FALSE;
    }
    else if ( fabs( crossa ) > fabs( crossb ) || crossa * crossb < 0.0f )
    {
		return FALSE;
    }
    else
    {
		crossa = a1yb1y * a2xa1x - a1xb1x * a2ya1y;
		
		if ( fabs( crossa ) > fabs( crossb ) || crossa * crossb< 0.0f )
		{
			return FALSE;   
		}
    }
    
		//----------------------------------------------------------------------
    
    return TRUE;
}

-(int)checkGraphForIntersections
{
	int numberOfIntersections = 0;
	for (int i=0 ; i < edgeCount; i++)
	{
		numberOfIntersectionsForEdge[i] = 0;
	}
	
	for(int i = 0 ; i < edgeCount - 1 ; i ++)
	{
		for (int  j = i+1 ; j < edgeCount ; j++) 
		{
			if( edges[i].vert1 != edges[j].vert1 && edges[i].vert1 != edges[j].vert2 
			   && edges[i].vert2 != edges[j].vert1 && edges[i].vert2 != edges[j].vert2)
			{
				
				if ( [self lineIntersect:vertices[edges[i].vert1] 
								  Point2:vertices[edges[i].vert2]  
								  Point3:vertices[edges[j].vert1] 
								  Point4:vertices[edges[j].vert2] ] )
				{
					numberOfIntersections++;
					numberOfIntersectionsForEdge[i]++;
					numberOfIntersectionsForEdge[j]++;
				}
			}
		}
	}
	return numberOfIntersections;
}

-(void)moveSelectedVertexToLocation:(CGPoint)location clippingRect:(CGRect)clippingRect
{
	if (selectedVertex >= 0 && selectedVertex < vertexCount) 
	{
		vertices[selectedVertex].x = location.x;
		vertices[selectedVertex].y = MAX ( clippingRect.origin.y ,MIN(location.y,clippingRect.origin.y+clippingRect.size.height) );
	}
}

- (id) initGraph:(int) lvl clippingRect:(CGRect)clippingRect
{
	self = [self init];
	
	clippingRect.size.width -= 10;
	clippingRect.size.height -= 10;
	clippingRect.origin.x += 5;
	clippingRect.origin.y += 5;
	
	if(lvl >= 0)
	{
		vertices[0].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[0].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[1].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[1].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[2].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[2].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[3].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[3].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[4].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[4].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[5].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[5].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 6;
		
		edges[0].vert1 = 0;
		edges[0].vert2 = 1;
		edges[1].vert1 = 0;
		edges[1].vert2 = 2;
		edges[2].vert1 = 0; 
		edges[2].vert2 = 3;
		edges[3].vert1 = 1;
		edges[3].vert2 = 3;
		edges[4].vert1 = 2;
		edges[4].vert2 = 4;
		edges[5].vert1 = 3;
		edges[5].vert2 = 4;
		edges[6].vert1 = 3;
		edges[6].vert2 = 5;
		edges[7].vert1 = 4;
		edges[7].vert2 = 5;
		
		edgeCount = 8;
	}	
	if(lvl >= 1)
	{
		vertices[6].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[6].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[7].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[7].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 8;
		
		edges[8].vert1 = 6;
		edges[8].vert2 = 5;
		edges[9].vert1 = 6;
		edges[9].vert2 = 7;
		edges[10].vert1 = 1;
		edges[10].vert2 = 7;
		
		edgeCount = 11;
	}
	if(lvl >= 2)
	{
		vertices[8].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[8].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 9;
		
		edges[11].vert1 = 1;
		edges[11].vert2 = 6;
		edges[12].vert1 = 5;
		edges[12].vert2 = 8;
		edges[13].vert1 = 6;
		edges[13].vert2 = 8;
		
		edgeCount = 14;
	}
	if(lvl >= 3)
	{
		
		vertices[9].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[9].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[10].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[10].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 11;
		
		edges[14].vert1 = 9;
		edges[14].vert2 = 4;
		edges[15].vert1 = 9;
		edges[15].vert2 = 8;
		edges[16].vert1 = 8;
		edges[16].vert2 = 10;
		edges[17].vert1 = 9;
		edges[17].vert2 = 10;
		
		edgeCount = 18;
	}
	if(lvl >= 4)
	{
		vertices[11].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[11].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[12].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[12].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 13;
		
		edges[18].vert1 = 0;
		edges[18].vert2 = 11;
		edges[19].vert1 = 11;
		edges[19].vert2 = 12;
		edges[20].vert1 = 7;
		edges[20].vert2 = 12;
		
		edgeCount = 21;
	}
	if(lvl >= 5)
	{
		vertices[13].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[13].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[14].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[14].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 15;
		
		edges[21].vert1 = 7;
		edges[21].vert2 = 13;
		edges[22].vert1 = 13;
		edges[22].vert2 = 14;
		edges[23].vert1 = 12;
		edges[23].vert2 = 14;
		
		edgeCount = 24;
	}
	if(lvl >= 6)
	{
		vertices[15].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[15].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 16;
		
		edges[24].vert1 = 12;
		edges[24].vert2 = 13;
		edges[25].vert1 = 9;
		edges[25].vert2 = 15;
		edges[26].vert1 = 10;
		edges[26].vert2 = 15;
		
		edgeCount = 27;
	}
	if(lvl >= 7)
	{
		vertices[16].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[16].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[17].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[17].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 18;
		
		edges[27].vert1 = 2;
		edges[27].vert2 = 16;
		edges[28].vert1 = 16;
		edges[28].vert2 = 17;
		edges[29].vert1 = 11;
		edges[29].vert2 = 17;
		
		edgeCount = 30;
	}
	if(lvl >= 8)
	{	
		vertices[18].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[18].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		vertices[19].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[19].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 20;
		
		edges[30].vert1 = 18;
		edges[30].vert2 = 17;
		edges[31].vert1 = 18;
		edges[31].vert2 = 19;
		edges[32].vert1 = 14;
		edges[32].vert2 = 19;
		
		edgeCount = 33;
	}
	if(lvl >= 9)
	{
		vertices[20].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[20].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 21;
		
		edges[33].vert1 = 17;
		edges[33].vert2 = 20;
		edges[34].vert1 = 18;
		edges[34].vert2 = 20;
		edges[35].vert1 = 11;
		edges[35].vert2 = 18;
		
		edgeCount = 36;
	}
	
	if(lvl >= 10)
	{
			//vertices[21].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
			//vertices[21].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 21;
		
		edges[36].vert1 = 1;
		edges[36].vert2 = 12;
		edges[37].vert1 = 16;
		edges[37].vert2 = 20;
		edges[38].vert1 = 15;
		edges[38].vert2 = 16;
		
		edgeCount = 39;
	}
	
	if(lvl >= 11)
	{
			//vertices[20].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
			//vertices[20].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 21;
		
		edges[39].vert1 = 12;
		edges[39].vert2 = 19;
		edges[40].vert1 = 11;
		edges[40].vert2 = 19;
		edges[41].vert1 = 2;
		edges[41].vert2 = 17;
		
		edgeCount = 42;
	}
	if(lvl >= 12)
	{
		vertices[21].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[21].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 22;
		
		edges[42].vert1 = 7;
		edges[42].vert2 = 21;
		edges[43].vert1 = 6;
		edges[43].vert2 = 21;
		edges[44].vert1 = 8;
		edges[44].vert2 = 21;
		edges[45].vert1 = 10;
		edges[45].vert2 = 21;
		
		edgeCount = 46;
	}
	if(lvl >= 13)
	{
		vertices[22].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[22].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 23;
		
		edges[46].vert1 = 13;
		edges[46].vert2 = 22;
		edges[47].vert1 = 21;
		edges[47].vert2 = 22;

		edgeCount = 48;
	}
	
	if(lvl >= 14)
	{
		vertices[23].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[23].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 24;
		
		edges[48].vert1 = 20;
		edges[48].vert2 = 23;
		edges[49].vert1 = 18;
		edges[49].vert2 = 23;
		edges[50].vert1 = 19;
		edges[50].vert2 = 23;
		
		edgeCount = 51;
	}
	
		///////////// PAID LEVELS
	
	if(lvl >= 15)
	{
		vertices[24].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[24].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 25;
		
		edges[51].vert1 = 24;
		edges[51].vert2 = 15;
		edges[52].vert1 = 16;
		edges[52].vert2 = 24;
		edges[53].vert1 = 3;
		edges[53].vert2 = 6;
		
		edgeCount = 54;
	}
	
	if(lvl >= 16)
	{
		vertices[25].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[25].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 26;
		
		edges[54].vert1 = 23;
		edges[54].vert2 = 25;
		edges[55].vert1 = 14;
		edges[55].vert2 = 25;
		edges[56].vert1 = 1;
		edges[56].vert2 = 11;
		
		edgeCount = 57;
	}
	
	if(lvl >= 17)
	{
		vertices[26].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[26].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 27;
		
		edges[57].vert1 = 26;
		edges[57].vert2 = 14;
		edges[58].vert1 = 13;
		edges[58].vert2 = 26;
		edges[59].vert1 = 26;
		edges[59].vert2 = 22;
		
		edgeCount = 60;
	}
	
	if(lvl >= 18)
	{
		vertices[27].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[27].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 28;
		
		edges[60].vert1 = 20;
		edges[60].vert2 = 27;
		edges[61].vert1 = 24;
		edges[61].vert2 = 27;
		
		edgeCount = 62;
	}
	
	if(lvl >= 19)
	{
		vertices[28].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[28].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 29;
		
		edges[62].vert1 = 14;
		edges[62].vert2 = 28;
		edges[63].vert1 = 25;
		edges[63].vert2 = 28;
		edges[64].vert1 = 26;
		edges[64].vert2 = 28;
		
		edgeCount = 65;
	}
	
	if(lvl >= 20)
	{
		vertices[29].x = arc4random()%(uint)(clippingRect.size.width) + (uint)(clippingRect.origin.x);
		vertices[29].y = arc4random()%(uint)(clippingRect.size.height) + (uint)(clippingRect.origin.y);
		
		vertexCount = 30;
		
		edges[65].vert1 = 29;
		edges[65].vert2 = 27;
		edges[66].vert1 = 29;
		edges[66].vert2 = 24;
		edges[67].vert1 = 29;
		edges[67].vert2 = 15;
		
		edgeCount = 68;
	}
	
	if(lvl >= 21)
	{
		edges[68].vert1 = 4;
		edges[68].vert2 = 15;
		edges[69].vert1 = 2;
		edges[69].vert2 = 3;
		edges[70].vert1 = 19;
		edges[70].vert2 = 25;
		
		edgeCount = 71;
	}
	
	if(lvl >= 22)
	{
		edges[71].vert1 = 2;
		edges[71].vert2 = 15;
		edges[72].vert1 = 5;
		edges[72].vert2 = 9;
		
		edgeCount = 73;
	}
	
	if(lvl >= 23)
	{
		edges[73].vert1 = 16;
		edges[73].vert2 = 27;
		edges[74].vert1 = 21;
		edges[74].vert2 = 26;
		
		edgeCount = 75;
	}
	
	if(lvl >= 24)
	{
		edges[75].vert1 = 25;
		edges[75].vert2 = 26;
		edges[76].vert1 = 25;
		edges[76].vert2 = 20;
		edges[77].vert1 = 20;
		edges[77].vert2 = 29;
		
		edgeCount = 78;
	}
	
	for (int i = 0 ; i < edgeCount ; i++) 
	{
		numberOfIntersectionsForEdge[i] = 0;
	}
	
	if ([self checkGraphForIntersections] <= (lvl+1)*2)
	{
		self = [self initGraph:lvl clippingRect:clippingRect];
	}
	
	return self;
}

@end
