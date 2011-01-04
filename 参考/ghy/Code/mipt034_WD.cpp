/*
          login:      Majia
          password:   fAf340u
*/
#include<cstdio>
struct point{
	double x,y;
}a[110];
long n;
double h,ans;

void init()
{
	scanf("%ld%lf",&n,&h);
	for (long i=1;i<=n+1;i++) scanf("%lf%lf",&a[i].x,&a[i].y);
	h=h*(a[n+1].x-a[1].x);
	a[n+2].x=a[n+1].x;a[n+2].y=1e50;
	a[0].x=a[1].x;a[0].y=1e50;
	n=n+2;
}

long _highest(long l,long r)
{
	long k=l+1;
	for (long i=l+1;i<r;i++)
		if (a[i].y>a[k].y) k=i;
	return k;
}

long _lowest(long l,long r)
{
	long k=l+1;
	for (long i=l+1;i<r;i++)
		if (a[i].y<a[k].y) k=i;
	return k;
}

double _min(double x,double y)
{
	return x>y?y:x;
}

double _area(long l,long r)
{
	double area=0,min=_min(a[l].y,a[r].y);
	if (r-l<=1) return 0;
	for (long i=l+1;i<r-1;i++)
		area=area+(a[i+1].x-a[i].x)*(min-a[i].y+min-a[i+1].y)/2;
	if (a[l].y>min+1e-8){
		area=area+(a[l+1].x-a[l].x)*(a[l].y-a[l+1].y)/2*(min-a[l+1].y)*(min-a[l+1].y)/(a[l].y-a[l+1].y)/(a[l].y-a[l+1].y);
		area=area+(a[r].x-a[r-1].x)*(min-a[r-1].y+min-a[r].y)/2;
	}
	else if (a[r].y>min){
		area=area+(a[r].x-a[r-1].x)*(a[r].y-a[r-1].y)/2*(min-a[r-1].y)*(min-a[r-1].y)/(a[r].y-a[r-1].y)/(a[r].y-a[r-1].y);
		area=area+(a[l+1].x-a[l].x)*(min-a[l].y+min-a[l+1].y)/2;
	}
	return area;
}

double _crossl(double h,point p1,point p2)
{
	return p2.x-(h-p2.y)/(p1.y-p2.y)*(p2.x-p1.x);
}
double _crossr(double h,point p1,point p2)
{
	return (h-p1.y)/(p2.y-p1.y)*(p2.x-p1.x)+p1.x;
}

void solve(long l,long r,double h)
{
	long highest=_highest(l,r);
	long lowest=_lowest(l,r);
	double height=0,aa=a[highest].y;
	double ll=_crossl(aa,a[l],a[l+1]),rr=_crossr(aa,a[r-1],a[r]);
	aa=rr-ll;
	double max=a[l].y,min=a[highest].y,mid;
	while (max-min>1e-7){
		mid=(max+min)/2;
		ll=_crossl(mid,a[l+1],a[l]),rr=_crossr(mid,a[r-1],a[r]);
		if ((rr-ll+aa)*(mid-a[highest].y)/2>h) max=mid;
		else min=mid;
	}
	height=mid;
	if (height-a[lowest].y>ans) ans=height-a[lowest].y;
}

void work(long l,long r,double h)
{
	if (l>=r-1) return;
	if (l>=r-2){
		solve(l,r,h);
		return;
	}
	long highest=_highest(l,r);
	double area1=_area(l,highest),area2=_area(highest,r);
	double h1=h*(a[highest].x-a[l].x)/(a[r].x-a[l].x),h2=h*(a[r].x-a[highest].x)/(a[r].x-a[l].x);
	if (h1+h2<area1+area2){
		if (h1>area1){
			solve(l,highest,0);
			work(highest,r,h2+h1-area1);
		}
		else if (h2>area2){
			solve(highest,r,0);
			work(l,highest,h1+h2-area2);
		}
		else{
			work(l,highest,h1);
			work(highest,r,h2);
		}
	}
	else solve(l,r,h-area1-area2);
}

int main()
{
	freopen("P034.in","r",stdin);
	freopen("out.txt","w",stdout);
	init();
	if (h==0) printf("0.0000\n");
	else{
		work(0,n,h);
		printf("%0.4lf\n",ans);
	}
	return 0;
}
