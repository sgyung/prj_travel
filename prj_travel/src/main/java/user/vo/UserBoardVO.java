package user.vo;

import java.util.Date;

public class UserBoardVO {
	private String boardId;
	private String userId;
	private String boardTitle;
	private String boardCategory;
	private String boardContent;
	private Date boardDate;
	private String boardState;
	private int boardViewNum;
	
	public UserBoardVO() {
		
	}

	public UserBoardVO(String boardId, String userId, String boardTitle, String boardCategory, String boardContent,
			Date boardDate, String boardState, int boardViewNum) {
		super();
		this.boardId = boardId;
		this.userId = userId;
		this.boardTitle = boardTitle;
		this.boardCategory = boardCategory;
		this.boardContent = boardContent;
		this.boardDate = boardDate;
		this.boardState = boardState;
		this.boardViewNum = boardViewNum;
	}

	public String getBoardId() {
		return boardId;
	}

	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardCategory() {
		return boardCategory;
	}

	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	public String getBoardState() {
		return boardState;
	}

	public void setBoardState(String boardState) {
		this.boardState = boardState;
	}

	public int getBoardViewNum() {
		return boardViewNum;
	}

	public void setBoardViewNum(int boardViewNum) {
		this.boardViewNum = boardViewNum;
	}

	@Override
	public String toString() {
		return "UserBoardVO [boardId=" + boardId + ", userId=" + userId + ", boardTitle=" + boardTitle
				+ ", boardCategory=" + boardCategory + ", boardContent=" + boardContent + ", boardDate=" + boardDate
				+ ", boardState=" + boardState + ", boardViewNum=" + boardViewNum + "]";
	}
	
	
}
