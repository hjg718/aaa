package team.board;

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
	
	public List<BoardVO> search
	(@Param("category") String cat,@Param("keyword") String key); //�˻�



	
}
