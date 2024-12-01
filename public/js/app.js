
//budge_detailが押された時
const budgeDetail = document.querySelector('.budge_detail');
const budge = document.querySelector('.budge');
const budgeClose = document.querySelector('.budge_close');

budgeDetail.addEventListener('click', function(){
    budge.style.display = 'block';
});

budgeClose.addEventListener('click', function(){
    budge.style.display = 'none';
});

// budgeの更新
const motionDayElement = document.querySelector('#motion_day');
const budgeDisplay = document.querySelector('#budge_display');
const budgeName = document.querySelector('#budge_name');

const motionDay = parseInt(motionDayElement.textContent, 10);

if (motionDay >= 14){
    budgeDisplay.src = 'images/budge_king.png';
    budgeName.textContent = 'King';
} else if (motionDay >= 7) {
    budgeDisplay.src = 'images/budge_queen.png';
    budgeName.textContent = 'Queen';
} else if (motionDay >= 5) {
    budgeDisplay.src = 'images/budge_rook.png';
    budgeName.textContent = 'Rook';
} else if (motionDay >= 3) {
    budgeDisplay.src = 'images/budge_bishop.png';
    budgeName.textContent = 'Bishop';
} else if (motionDay >= 1) {
    budgeDisplay.src = 'images/budge_knght.png';
    budgeName.textContent = 'Knight';
} else {
    budgeDisplay.src = 'images/budge_pawn.png';
    budgeName.textContent = 'Pawn';
}

// コメントの表示
const comment = document.querySelector('#comment');

let comment_array = ['ゆっくりしたペースでのウォーキングは、創造的なアイデアを生み出す力を高めると研究で示されています。自然の中を歩くとその効果はさらに増します。',
    '大笑いをすると、ストレスホルモンが減少し、免疫系が活性化されます。日常的に笑顔を増やすことが健康に寄与します。',
    '短時間の瞑想でも、脳の灰白質（記憶や学習に関与する部分）が増加し、ストレス管理能力が向上すると言われています。',
    '体内の水分がわずか2%失われるだけで、集中力や認知機能が低下します。こまめな水分補給が重要です。',
    '睡眠が不足すると、食欲を調整するホルモン（グレリンとレプチン）のバランスが乱れ、過食を引き起こす可能性があります。',
    'たった10分間の軽い運動でも、エンドルフィンが分泌され、気分が良くなったりストレスが軽減されたりします。',
    '背筋を伸ばして座るだけで、自信が高まり、ストレスや不安を感じにくくなる効果が報告されています。',
    'カカオが豊富なダークチョコレートは、抗酸化物質を含み、集中力や記憶力を向上させる可能性があります。',
    '森林浴や植物に囲まれる時間を持つことで、ストレスホルモンのコルチゾールが低下し、心の健康が向上します。',
    '運動後30分以内は「ゴールデンタイム」と呼ばれ、タンパク質や炭水化物を摂取することで筋肉の修復やエネルギー回復が促進されます。',
    '1日10分の運動でも心臓や筋肉に良い影響を与えることができます。特に高強度インターバルトレーニング（HIIT）は短時間で効果的です。',
    '適度な運動は、睡眠の質を向上させるだけでなく、入眠しやすくする効果もあります。ただし、寝る直前の激しい運動は逆効果になることがあります。',
    '階段を上り下りしたり、椅子を使ったスクワットや腕立て伏せを行ったりと、ちょっとした工夫で日常生活に運動を取り入れられます。',
    '定期的な運動は体だけでなく脳にも影響を与えます。特に有酸素運動は、脳内の神経成長因子（BDNF）を増やし、記憶力や学習能力を向上させると言われています。さらに、うつ症状の軽減にも効果的です。'
];

let randomIndex = Math.floor(Math.random() * comment_array.length);
comment.textContent = comment_array[randomIndex];

// 達成割合を表示
const completionRate = document.querySelector('.completion_rate');
const caloriesBurn = document.querySelector('.calories_burn');

const caloriesText = caloriesBurn.textContent.split('kcl')[0];
const calories = parseFloat(caloriesText);

const goalCalories = 2000;
const rate = (calories / goalCalories) * 100;

if (rate == 0) {
    completionRate.textContent = '0%'; 
} else if(rate >= 100){
    completionRate.textContent = '100%'; 
}else {
    completionRate.textContent = `${rate.toFixed(1)}%`;
}

// グラフの長さを更新
const border = document.querySelector('#border');
const completionRateValue = parseFloat(completionRate.textContent);
const length = 600 * (completionRateValue / 100);

border.style.backgroundSize = `${length}px`;
