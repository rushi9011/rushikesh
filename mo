 /// <summary>
    /// Current project Id.
    /// </summary>
    public DefaultIdType ProjectId { get; set; }

    /// <summary>
    /// Item Text details.
    /// </summary>
    public ProjectItemDetails ProjectItemDetails { get; set; } = default!;

    /// <summary>
    /// User Id for whom item belongs to.
    /// </summary>
    public DefaultIdType UserId { get; set; }

    /// <summary>
    /// 0-Save , 1-Complete.
    /// </summary>
    public ItemStatus ItemStatus { get; set; }

}

public class ProjectItemDetails
{
    /// <summary>
    ///Project Item Id if generated.
    /// </summary>
    public DefaultIdType? ItemId { get; set; }

    /// <summary>
    /// Item Title Id for Dual Languages. There will be single Item title Id.
    /// </summary>
    public DefaultIdType? ItemTitleId { get; set; }

    /// <summary>
    /// Item Title.
    /// </summary>
    public string? ItemTitle { get; set; }

    /// <summary>
    /// Item Text.
    /// </summary>
    public string ItemText { get; set; } = default!;

    /// <summary>
    /// Item Marks.
    /// </summary>
    public decimal ItemMark { get; set; } = 0;

    /// <summary>
    /// Item Instruction.
    /// </summary>
    public string? Instruction { get; set; }

    /// <summary>
    /// Comprehension Id.
    /// </summary>
    public DefaultIdType? ComprehensionId { get; set; }

    /// <summary>
    /// Project Item Type Id.
    /// </summary>
    public DefaultIdType ItemTypeId { get; set; }

    /// <summary>
    /// Langugage Id for the Item.
    /// </summary>
    public DefaultIdType LanguageId { get; set; } = default!;

    /// <summary>
    /// Category Id for the Item.
    /// </summary>
    public DefaultIdType? CategoryId { get; set; } = default!;

    /// <summary>
    /// Attribute Value for the primary attribute.
    /// </summary>
    public DefaultIdType? AttributeValueId { get; set; }

    /// <summary>
    /// Attribute Values for the secondary attribute.
    /// </summary>
    public List<SecondryAttributeDetails>? SecondryAttributeDetails { get; set; }

    /// <summary>
    /// Remarks for the item.
    /// </summary>
    public string Remarks { get; set; } = default!;

    /// <summary>
    /// Current ItemStepId for the item.
    /// </summary>
    public DefaultIdType? CurrentItemStepId { get; set; } = default!;

    /// <summary>
    /// Options for the item.
    /// </summary>
    public List<OptionDetails>? Options { get; set; }

}

public class SecondryAttributeDetails
{
    /// <summary>
    /// Category Id for the Item.
    /// </summary>
    public DefaultIdType? CategoryId { get; set; }

    /// <summary>
    /// Attribute Value for the secondry attribute.
    /// </summary>
    public DefaultIdType? AttributeValueId { get; set; }
}

public class OptionDetails
{
    /// <summary>
    /// Option Id.
    /// </summary>
    public DefaultIdType? OptionId { get; set; }

    /// <summary>
    /// Option Text.
    /// </summary>
    public string OptionText { get; set; } = default!;

    /// <summary>
    /// Option Code.
    /// </summary>
    public string OptionCode { get; set; } = default!;

    /// <summary>
    /// Option Marks.
    /// </summary>
    public decimal OptionMark { get; set; } = 0;

    public bool Exclusive { get; set; } = false;
    public bool LockPosition { get; set; } = false;

}
