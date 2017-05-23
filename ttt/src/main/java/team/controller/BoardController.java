package team.controller;

import java.util.*;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import team.board.model.Board;
import team.board.model.BoardVO;
import team.service.BoardService;


@Controller
@RequestMapping("board/")
public class BoardController {

	@Autowired
	private BoardService svc;
	
	//�Խ��� ù ȭ�� 
	@RequestMapping(value="list")
	public String boardListStart(Model model){
		Board b = svc.boardFirstPage(1);
		List<BoardVO> list = b.getList();
		model.addAttribute("total",b.getTotalpage());
		model.addAttribute("curr", b.getCurrpage());
		model.addAttribute("boardlist",list);
		
		List<BoardVO> goodList =svc.goodList();//��õ���� ���� ����Ʈ
		model.addAttribute("goodlist",goodList);
		return "board/boardList";
	}
	//������ ��ȣ
	@RequestMapping("listPage")
	@ResponseBody
	public List<BoardVO> listPage(Model model, @RequestParam("page") int page){
		Board b = svc.boardPage(page);
		List<BoardVO> list = b.getList();
		model.addAttribute("list",list);
		return list;
	}
	//�Խ��� �� ����1
	@RequestMapping("inputPage")
	public String inputPage(Model model, BoardVO board){
		return "board/boardInput";
	}
	//�Խ��� �� ����2
	@RequestMapping(value="input")
	public String input(Model model, BoardVO board){
		boolean ok = svc.input(board);
		if(ok){
			BoardVO vo = svc.info(board.getNum());
			model.addAttribute("board", vo);
		}
		return "board/boardRecent";
	}
	
	//���
	@RequestMapping("boardRepl")
	@ResponseBody
	public String boardRepl(Model model,BoardVO board){
		boolean ok = svc.input(board);
		JSONObject job = new JSONObject();
		job.put("ok", ok);
		return job.toJSONString();
	}
	
	//���� Ŭ���� ���� �о����  , ��ȸ��
	@RequestMapping("info")
	public String info(@RequestParam("num") int num,BoardVO boardvo,Model model){
		svc.readCnt(boardvo); // ��ȸ��  void �̰� ���� ����
		//svc.readCnt(boardVO) ������ �ؿ��� ���� �ȴ�.
		BoardVO list = svc.info(num);
		model.addAttribute("list",list);
		return "board/boardInfo";
	}
	
	//����1
	@RequestMapping("edit")
	public String edit(Model model, @RequestParam("num") int num){
		BoardVO list = svc.info(num);
		model.addAttribute("list",list);
		return "board/boardEdit";
	}
	//����2
	@RequestMapping("update")
	@ResponseBody
	public String update(Model model,BoardVO board){
		boolean ok = svc.update(board);
		JSONObject job = new JSONObject();
		job.put("ok",ok);
		return job.toJSONString();
	}
	//����
	@RequestMapping("delete")
	@ResponseBody
	public String delete(Model model , @RequestParam("num") int num){
		boolean ok = svc.delete(num);
		JSONObject job= new JSONObject();
			job.put("ok", ok);
		return job.toJSONString();
	}
	//�˻�
	@RequestMapping("search")
	@ResponseBody
	public String search(Model model,@RequestParam("category") String cat,
									 @RequestParam("keyword") String key,
									 @RequestParam("page") int page){
			String list = svc.search(cat, key, page);
			return list;
	}
	//��õ
	@RequestMapping("good")
	@ResponseBody
	public String goodCnt(BoardVO board){
			boolean ok = svc.goodCnt(board);
			JSONObject job = new JSONObject();
			job.put("ok",ok);
		return job.toJSONString();
	}
	
	@RequestMapping("recent")
	public String recent(@RequestParam("id")String id, Model model){
		BoardVO vo = svc.recent(id);
		model.addAttribute("board",vo);
		return "board/boardRecent";
	}
}
