const String scheduleMock = '''
{
  "group": {
    "id": "0e2f45db-ef16-4af4-99a3-f2d73b7f888f",
    "name": "ИТ2342"
  },
  "weeks": [
    {
      "id": "c2163138-a3cd-439a-85e8-bbbfac24a180",
      "week_number": 1,
      "lessons": [
        {
          "id": "99e331fb-b8d4-42f0-8e3f-0b1c9d37f13d",
          "day_of_week": 1,
          "lesson_number": 3,
          "is_lecture": false,
          "discipline": {
            "id": "ae05e4c8-fa18-4fa7-8411-7858b4d08ea6",
            "name": "Логика и методология науки"
          },
          "teachers": [
            {
              "id": "162be091-d605-4536-a75f-02f235950f5e",
              "fio": "Плотников В. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "36f73c90-f7fb-4225-baea-3da51a6ac83a",
              "name": "8эл"
            }
          ]
        },
        {
          "id": "b76e3d3f-f239-43b0-bf8f-8fdef33207c6",
          "day_of_week": 1,
          "lesson_number": 4,
          "is_lecture": false,
          "discipline": {
            "id": "eb9331dd-8cf1-44a1-8b11-c920ebb28bfe",
            "name": "Современные сетевые и телекоммуникационные технологии"
          },
          "teachers": [
            {
              "id": "22d2cd74-ed0d-41ea-8580-690be0809a8d",
              "fio": "Алашеев В. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "1801dd08-67c4-4a20-a370-6698c3db93bc",
              "name": "415зр"
            }
          ]
        },
        {
          "id": "376d38d6-a9d6-4b5c-a13f-c7f0b003ebf6",
          "day_of_week": 1,
          "lesson_number": 5,
          "is_lecture": false,
          "discipline": {
            "id": "2437bca2-7260-47d2-b4c1-f6044bfc1dfb",
            "name": "Иностранный язык"
          },
          "teachers": [
            {
              "id": "3843ca82-7d78-4faf-914d-0a656003aa77",
              "fio": "Алещанова И. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "c855a2fa-3f5a-4d63-8071-fd18ab1a7a7b",
              "name": "021зоо"
            }
          ]
        },
        {
          "id": "283a48e4-2665-4b58-b294-9d341ef746af",
          "day_of_week": 2,
          "lesson_number": 5,
          "is_lecture": false,
          "discipline": {
            "id": "0d903f53-c48d-4f04-9750-f745163e95d2",
            "name": "Инженерия информационных систем"
          },
          "teachers": [
            {
              "id": "1b2e2c83-d0cb-4eb2-bd0e-6bfb36ba5cca",
              "fio": "Русак С. Н.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "98cb9a02-ff1f-4fb1-8aa4-5d5777ffdc96",
              "name": "303гд"
            }
          ]
        },
        {
          "id": "42d6d142-7890-4335-8c8d-7f4d55f449b5",
          "day_of_week": 2,
          "lesson_number": 6,
          "is_lecture": false,
          "discipline": {
            "id": "0d903f53-c48d-4f04-9750-f745163e95d2",
            "name": "Инженерия информационных систем"
          },
          "teachers": [
            {
              "id": "1b2e2c83-d0cb-4eb2-bd0e-6bfb36ba5cca",
              "fio": "Русак С. Н.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "98cb9a02-ff1f-4fb1-8aa4-5d5777ffdc96",
              "name": "303гд"
            }
          ]
        },
        {
          "id": "f89e57b4-2e08-4fdf-b3d4-fd9d3b6651ad",
          "day_of_week": 4,
          "lesson_number": 1,
          "is_lecture": true,
          "discipline": {
            "id": "4e1ae2fb-248f-434e-8a04-57587faf478b",
            "name": "Экономико-математические модели управления"
          },
          "teachers": [
            {
              "id": "492fcaf7-c343-47a2-915d-ce7f12cef185",
              "fio": "Бурда А. Г.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "79679b62-8251-45ff-9777-cc5b93de64d4",
              "name": "313зоо"
            }
          ]
        },
        {
          "id": "7baa5792-5284-451a-a920-d43e4c3d6264",
          "day_of_week": 4,
          "lesson_number": 2,
          "is_lecture": true,
          "discipline": {
            "id": "ae05e4c8-fa18-4fa7-8411-7858b4d08ea6",
            "name": "Логика и методология науки"
          },
          "teachers": [
            {
              "id": "162be091-d605-4536-a75f-02f235950f5e",
              "fio": "Плотников В. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "f4c3434a-6df1-40af-8849-52dd352672a7",
              "name": "513гд"
            }
          ]
        },
        {
          "id": "759aabea-289f-4961-b2ab-6ed28fd39e0e",
          "day_of_week": 5,
          "lesson_number": 4,
          "is_lecture": false,
          "discipline": {
            "id": "4e1ae2fb-248f-434e-8a04-57587faf478b",
            "name": "Экономико-математические модели управления"
          },
          "teachers": [
            {
              "id": "492fcaf7-c343-47a2-915d-ce7f12cef185",
              "fio": "Бурда А. Г.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "56c1ec7f-7c6b-4e60-bf3e-d11d5ab6e65a",
              "name": "581мх"
            }
          ]
        },
        {
          "id": "5c07d1e6-9c08-4a1e-bfe1-59cf4095909c",
          "day_of_week": 5,
          "lesson_number": 5,
          "is_lecture": false,
          "discipline": {
            "id": "309130a6-706e-40e5-8fe2-c258eb41982b",
            "name": "Специальные главы математики"
          },
          "teachers": [
            {
              "id": "d3c69f6b-c73f-417f-a901-eff94f122040",
              "fio": "Третьякова Н. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "08364716-0eba-49f9-a532-9cf2e29d291e",
              "name": "16гд"
            }
          ]
        }
      ],
      "dt_updated": "2023-09-17T22:02:12+00:00",
      "dt_checked": "2023-09-19T18:36:54.520984+00:00"
    },
    {
      "id": "377ae1e4-b2eb-4aea-92e5-d04d298c46b4",
      "week_number": 2,
      "lessons": [
        {
          "id": "5cdd9227-334d-460d-be99-0dd652b02371",
          "day_of_week": 1,
          "lesson_number": 5,
          "is_lecture": true,
          "discipline": {
            "id": "0d903f53-c48d-4f04-9750-f745163e95d2",
            "name": "Инженерия информационных систем"
          },
          "teachers": [
            {
              "id": "1b2e2c83-d0cb-4eb2-bd0e-6bfb36ba5cca",
              "fio": "Русак С. Н.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "79679b62-8251-45ff-9777-cc5b93de64d4",
              "name": "313зоо"
            }
          ]
        },
        {
          "id": "7e6f7df8-4c3d-45f7-b4d8-8ad40043df68",
          "day_of_week": 1,
          "lesson_number": 6,
          "is_lecture": false,
          "discipline": {
            "id": "fc4b050f-f120-41c1-838d-90bf89d1b85a",
            "name": "Базы и банки данных"
          },
          "teachers": [
            {
              "id": "1b2e2c83-d0cb-4eb2-bd0e-6bfb36ba5cca",
              "fio": "Русак С. Н.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "bae0ae22-0c94-42ab-987c-15f72d14ecc5",
              "name": "010зоо"
            }
          ]
        },
        {
          "id": "2e1de5ba-02c2-42ee-a8f3-54cb2011a7e5",
          "day_of_week": 2,
          "lesson_number": 4,
          "is_lecture": true,
          "discipline": {
            "id": "fc4b050f-f120-41c1-838d-90bf89d1b85a",
            "name": "Базы и банки данных"
          },
          "teachers": [
            {
              "id": "00885ba2-487d-4772-9905-554b304c70c3",
              "fio": "Лукьяненко Т. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "56c1ec7f-7c6b-4e60-bf3e-d11d5ab6e65a",
              "name": "581мх"
            }
          ]
        },
        {
          "id": "b0e03b3e-3bd1-4aab-875f-a675ca6d9868",
          "day_of_week": 2,
          "lesson_number": 5,
          "is_lecture": true,
          "discipline": {
            "id": "309130a6-706e-40e5-8fe2-c258eb41982b",
            "name": "Специальные главы математики"
          },
          "teachers": [
            {
              "id": "d3c69f6b-c73f-417f-a901-eff94f122040",
              "fio": "Третьякова Н. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "08364716-0eba-49f9-a532-9cf2e29d291e",
              "name": "16гд"
            }
          ]
        },
        {
          "id": "b7b757f2-77ed-4bcf-b0df-a4f7a6047f04",
          "day_of_week": 2,
          "lesson_number": 6,
          "is_lecture": false,
          "discipline": {
            "id": "309130a6-706e-40e5-8fe2-c258eb41982b",
            "name": "Специальные главы математики"
          },
          "teachers": [
            {
              "id": "d3c69f6b-c73f-417f-a901-eff94f122040",
              "fio": "Третьякова Н. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "08364716-0eba-49f9-a532-9cf2e29d291e",
              "name": "16гд"
            }
          ]
        },
        {
          "id": "3708659e-3df4-49e5-9a7a-12fcb1bdb813",
          "day_of_week": 4,
          "lesson_number": 2,
          "is_lecture": false,
          "discipline": {
            "id": "0d903f53-c48d-4f04-9750-f745163e95d2",
            "name": "Инженерия информационных систем"
          },
          "teachers": [
            {
              "id": "1b2e2c83-d0cb-4eb2-bd0e-6bfb36ba5cca",
              "fio": "Русак С. Н.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "9360fc19-6b90-4c33-935b-5517a2ca739e",
              "name": "129"
            },
            {
              "id": "c1b46f2f-9a1e-43da-a5c2-53ef4d9fed95",
              "name": "1общ"
            }
          ]
        },
        {
          "id": "20e89ca5-fc7a-487e-ac38-5f183a9f9480",
          "day_of_week": 4,
          "lesson_number": 3,
          "is_lecture": false,
          "discipline": {
            "id": "fc4b050f-f120-41c1-838d-90bf89d1b85a",
            "name": "Базы и банки данных"
          },
          "teachers": [
            {
              "id": "1b2e2c83-d0cb-4eb2-bd0e-6bfb36ba5cca",
              "fio": "Русак С. Н.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "8e568547-badc-409d-b5be-9c79cfad39d7",
              "name": "205эл"
            }
          ]
        },
        {
          "id": "6c1857a4-fd2f-4007-b4ef-dc79025313f4",
          "day_of_week": 5,
          "lesson_number": 2,
          "is_lecture": false,
          "discipline": {
            "id": "2437bca2-7260-47d2-b4c1-f6044bfc1dfb",
            "name": "Иностранный язык"
          },
          "teachers": [
            {
              "id": "3843ca82-7d78-4faf-914d-0a656003aa77",
              "fio": "Алещанова И. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "c855a2fa-3f5a-4d63-8071-fd18ab1a7a7b",
              "name": "021зоо"
            }
          ]
        },
        {
          "id": "3ba04aaa-9239-4ad8-bc1c-1f8f6ebd16ec",
          "day_of_week": 5,
          "lesson_number": 3,
          "is_lecture": true,
          "discipline": {
            "id": "eb9331dd-8cf1-44a1-8b11-c920ebb28bfe",
            "name": "Современные сетевые и телекоммуникационные технологии"
          },
          "teachers": [
            {
              "id": "22d2cd74-ed0d-41ea-8580-690be0809a8d",
              "fio": "Алашеев В. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "a29dc950-a749-4c2f-b039-c97707c39f73",
              "name": "226гл"
            }
          ]
        },
        {
          "id": "e2ec27b8-cf89-403a-ac47-f62e208295ea",
          "day_of_week": 5,
          "lesson_number": 4,
          "is_lecture": false,
          "discipline": {
            "id": "4e1ae2fb-248f-434e-8a04-57587faf478b",
            "name": "Экономико-математические модели управления"
          },
          "teachers": [
            {
              "id": "492fcaf7-c343-47a2-915d-ce7f12cef185",
              "fio": "Бурда А. Г.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "bb5c2def-6d35-4406-af08-30c2593fb32c",
              "name": "416эл"
            }
          ]
        },
        {
          "id": "aefb5491-5466-4041-ac0f-c6ad74fb59cd",
          "day_of_week": 5,
          "lesson_number": 5,
          "is_lecture": false,
          "discipline": {
            "id": "eb9331dd-8cf1-44a1-8b11-c920ebb28bfe",
            "name": "Современные сетевые и телекоммуникационные технологии"
          },
          "teachers": [
            {
              "id": "22d2cd74-ed0d-41ea-8580-690be0809a8d",
              "fio": "Алашеев В. В.",
              "url": "https://kubsau.ru/"
            }
          ],
          "audiences": [
            {
              "id": "bb5c2def-6d35-4406-af08-30c2593fb32c",
              "name": "416эл"
            }
          ]
        }
      ],
      "dt_updated": "2023-09-15T12:03:15+00:00",
      "dt_checked": "2023-09-19T18:36:54.520958+00:00"
    }
  ]
}
''';
