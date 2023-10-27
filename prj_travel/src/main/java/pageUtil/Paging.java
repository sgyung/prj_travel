package pageUtil;

public class Paging {
	private static Paging paging;
	
	private Paging() {
		
	}//Paging
	
	public static Paging getInstance() {
		if( paging == null ) {
			paging = new Paging();
		}//end if
		
		return paging;
	}//getInstance
	
	public int[] getPageRowRange( int currentPage, int pageScale ) {
		
		int qnaStartRow = currentPage * pageScale - pageScale + 1;
		int qnaEndRow = qnaStartRow + pageScale - 1;
		
		int[] resultArr = { qnaStartRow, qnaEndRow };
		
		return resultArr;
	}//getPageRowRange
	
	public int getTotalPage( int totalData, int pageScale ) {
		int result = (int)Math.ceil( totalData / (double)pageScale );
		return result;
	}
	
	public int[] getTotalPageCnt(int selectPage, int totalPage, int pagePerNum) {
		
		int currentBlock = selectPage % pagePerNum == 0 ? selectPage / pagePerNum : ( selectPage / pagePerNum ) + 1;
		
		int startPage = ( currentBlock - 1 ) * pagePerNum + 1;
		int endPage = startPage + pagePerNum - 1;
		
		if( endPage > totalPage ) {
			endPage = totalPage;
		}//end if
		
		int [] resultArr = { startPage, endPage };
		
		return resultArr;
	}//getTotalPageCnt
}
