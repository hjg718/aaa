package team.board.model;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardDAO {
	public Board boardPage(int pageNum); //����Ʈ,������ ��ȣ
	public int input(BoardVO board); // �� �۾���
	public BoardVO info(int num);//���� Ŭ���� ���� �����ֱ�
	public int update(BoardVO board); //����
	public int delete(int num); //����
	public void readCnt(BoardVO board); //��ȸ��
	public List<BoardVO> goodList();//��õ�� ����Ʈ
	
	public int goodCnt(BoardVO board);//��õ��
	public void goodCntUser(BoardVO board);//��õ�� ����
	public List<BoardVO> goodUserList(BoardVO board);//��õ�� ���̵�� ��õ�� ����Ʈ 
	
	public List<BoardVO> search(
	@Param("category") String cat,@Param("keyword") String key, @Param("page") int page ); //�˻�
	public BoardVO recent(String id);
	
	


	
}
