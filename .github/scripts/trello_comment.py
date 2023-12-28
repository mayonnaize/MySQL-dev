from typing import Optional
import requests
import json
import argparse

SUCCESS, FAIL, REQ_SUCCESS = 0, -1, 200

SETTINGS: str = "./settings.json"
BOARD_URL: str = "https://api.trello.com/1/members/me/boards"
CARD_URL: str = "https://api.trello.com/1/boards/{}/cards"
PARAMS: dict = {
    "fields": "name",
    "key": "",
    "token": "",
}

def get_trello_id(url: str, tgt_name: str)->Optional[str]:
    """ボード名やカード名からIDを取得する
    Args:
        url (str): URL
        tgt_name (str): ボード名やカード名
    Returns:
        Optional[str]: IDかNone
    """
    response: requests.Response = requests.get(url, params=PARAMS)
    if response.status_code == REQ_SUCCESS:
        content: list[dict] = json.loads(response.content)
        for c in content:
            if c["name"] == tgt_name:
                return c["id"]

def post_comment(card_id: str, comment: str) -> bool:
    """コメントを投稿する
    Args:
        card_id (str): カードのID
        comment (str): コメント内容
    Returns:
        bool: 実行結果
    """
    url: str = f"https://api.trello.com/1/cards/{card_id}/actions/comments"
    params: dict = PARAMS.copy()
    del params["fields"]
    params["text"] = comment
    response: requests.Response = requests.post(url, params=params)
    return response.status_code == REQ_SUCCESS

def main():
    # コマンド引数解析
    global PARAMS
    parser = argparse.ArgumentParser()
    parser.add_argument("api_key", help="TrelloのAPIキー")
    parser.add_argument("token", help="Trelloのトークン")
    parser.add_argument("branch", help="ブランチ名")
    parser.add_argument("comment", help="Trelloに投稿するコメント内容")
    args = parser.parse_args()

    PARAMS["key"] = args.api_key
    PARAMS["token"] = args.token
    branch: str = args.branch
    comment: str = args.comment

    # settings.jsonを読み込む
    with open(SETTINGS, "r") as f:
        settings = json.load(f)
    if branch not in settings["board"]["branches"].keys():
        print(f'[ERROR] No Branch Key Named "{branch}" in {SETTINGS}.')
        exit(FAIL)

    tgt_board: str = settings["board"]["name"]
    tgt_card: str = settings["board"]["branches"][branch]

    # 投稿する
    if (board_id := get_trello_id(BOARD_URL, tgt_board)) is not None and \
        (card_id := get_trello_id(CARD_URL.format(board_id), tgt_card)) is not None and \
        post_comment(card_id, comment):
        exit(SUCCESS)
    else:
        exit(FAIL)

if __name__ == "__main__":
    main()
