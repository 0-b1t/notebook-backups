import urllib.robotparser
import requests
from bs4 import BeautifulSoup
import pandas as pd


BASE_URL = 'https://www.space.com/news/'
ROBOTS_TXT_URL = 'https://www.space.com/robots.txt'

ARTICLE_CARD_SELECTOR = 'article'
AUTHOR_SELECTOR = '.by-author span'
TITLE_SELECTOR = '.article-name'
SYNOPSIS_SELECTOR = '.synopsis'
DATETIME_SELECTOR = 'time'


def get_space_news(page=1):
    page_url = BASE_URL + str(page)

    robot_parser = urllib.robotparser.RobotFileParser()
    robot_parser.set_url(ROBOTS_TXT_URL)
    robot_parser.read()

    # Check permission
    if not robot_parser.can_fetch(useragent='*', url=page_url):
        raise PermissionError('page disallowed for user-agent')

    response = requests.get(page_url)
    html_text = response.text

    soup = BeautifulSoup(html_text, 'html.parser')
    article_cards = soup.select(ARTICLE_CARD_SELECTOR)

    articles = []
    for card in article_cards:
        title = card.select(TITLE_SELECTOR)[0].text.strip()
        authors = [x.text.strip() for x in card.select(AUTHOR_SELECTOR)]
        synopsis = card.select(SYNOPSIS_SELECTOR)[0].text.strip()
        date_time = card.select(DATETIME_SELECTOR)[0]['datetime']

        article = {
            'title': title,
            'authors': authors,
            'synopsis': synopsis,
            'date_time': date_time,
        }

        articles.append(article)

    return pd.DataFrame(articles)


if __name__ == '__main__':
    # Get new home page
    page_1_article_df = get_space_news()
    page_2_article_df = get_space_news(page=2)

    article_df = pd.concat((page_1_article_df, page_2_article_df))
    print(article_df)
