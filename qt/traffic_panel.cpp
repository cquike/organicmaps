#include "qt/traffic_panel.hpp"
#include "qt/traffic_mode.hpp"

#include <QAbstractTableModel>
#include <QBoxLayout>
#include <QComboBox>
#include <QHeaderView>
#include <QStyledItemDelegate>
#include <QTableView>

// ComboBoxDelegate --------------------------------------------------------------------------------
ComboBoxDelegate::ComboBoxDelegate(QObject * parent)
  : QStyledItemDelegate(parent)
{
}

QWidget * ComboBoxDelegate::createEditor(QWidget * parent, QStyleOptionViewItem const & option,
                                         QModelIndex const & index) const
{
  auto * editor = new QComboBox(parent);
  editor->setFrame(false);
  editor->setEditable(false);
  editor->addItems({"Unevaluated", "Positive", "Negative", "RelPositive", "RelNegative", "Ignore"});

  return editor;
}

void ComboBoxDelegate::setEditorData(QWidget * editor, QModelIndex const & index) const
{
  auto const value = index.model()->data(index, Qt::EditRole).toString();
  static_cast<QComboBox*>(editor)->setCurrentText(value);
}

void ComboBoxDelegate::setModelData(QWidget * editor, QAbstractItemModel * model,
                                    QModelIndex const & index) const
{
  model->setData(index, static_cast<QComboBox*>(editor)->currentText(), Qt::EditRole);
}

void ComboBoxDelegate::updateEditorGeometry(QWidget * editor, QStyleOptionViewItem const & option,
                                            QModelIndex const & index) const
{
  editor->setGeometry(option.rect);
}

// TrafficPanel ------------------------------------------------------------------------------------
TrafficPanel::TrafficPanel(QAbstractItemModel * trafficModel, QWidget * parent)
  : QWidget(parent)
{
  CreateTable(trafficModel);

  auto * layout = new QVBoxLayout();
  layout->addWidget(m_table);
  setLayout(layout);
}

void TrafficPanel::CreateTable(QAbstractItemModel * trafficModel)
{
  m_table = new QTableView();
  m_table->setFocusPolicy(Qt::NoFocus);
  m_table->setAlternatingRowColors(true);
  m_table->setShowGrid(false);
  m_table->setSelectionBehavior(QAbstractItemView::SelectionBehavior::SelectRows);
  m_table->setSelectionMode(QAbstractItemView::SelectionMode::SingleSelection);
  m_table->verticalHeader()->setVisible(false);
  m_table->horizontalHeader()->setVisible(false);
  m_table->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);

  m_table->setModel(trafficModel);
  m_table->setItemDelegate(new ComboBoxDelegate());

  connect(m_table->selectionModel(),
          SIGNAL(selectionChanged(QItemSelection const &, QItemSelection const &)),
          trafficModel, SLOT(OnItemSelected(QItemSelection const &, QItemSelection const &)));
}
