package team.board.model;

import java.util.List;

public class Board {
	
	
	private List<BoardVO> list;
	private int totalpage; // �� ������
	private int currpage; // ���� ������
	
	//------------------------------------------------
	
	public List<BoardVO> getList() {return list;}
	public void setList(List<BoardVO> list) {this.list = list;}
	
	public int getTotalpage() {return totalpage;}
	public void setTotalpage(int totalpage) {this.totalpage = totalpage;}
	
	public int getCurrpage() {return currpage;}
	public void setCurrpage(int currpage) {this.currpage = currpage;}
	
	
	
	
	
}
